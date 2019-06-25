Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647F2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfFYUFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:05:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57456 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFYUFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:05:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B607B1A0882;
        Tue, 25 Jun 2019 22:05:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A95911A087C;
        Tue, 25 Jun 2019 22:05:15 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 55FC1205E5;
        Tue, 25 Jun 2019 22:05:15 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/gdb: add helpers to find and list devices
Date:   Tue, 25 Jun 2019 23:05:12 +0300
Message-Id: <c948628041311cbf1b9b4cff3dda7d2073cb3eaa.1561492937.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
References: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
In-Reply-To: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
References: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper commands and functions for finding pointers to struct device
by enumerating linux device bus/class infrastructure. This can be used
to fetch subsystem and driver-specific structs:

(gdb) p *$container_of($lx_device_find_by_class_name("net", "eth0"), "struct net_device", "dev")
(gdb) p *$container_of($lx_device_find_by_bus_name("i2c", "0-004b"), "struct i2c_client", "dev")
(gdb) p *(struct imx_port*)$lx_device_find_by_class_name("tty", "ttymxc1")->parent->driver_data

Several generic "lx-device-list" functions are included to enumerate
devices by bus and class:

(gdb) lx-device-list-bus usb
(gdb) lx-device-list-class
(gdb) lx-device-list-tree &platform_bus

Similar information is available in /sys but pointer values are
deliberately hidden.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 scripts/gdb/linux/device.py | 182 ++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py  |   1 +
 2 files changed, 183 insertions(+)
 create mode 100644 scripts/gdb/linux/device.py

diff --git a/scripts/gdb/linux/device.py b/scripts/gdb/linux/device.py
new file mode 100644
index 000000000000..16376c5cfec6
--- /dev/null
+++ b/scripts/gdb/linux/device.py
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) NXP 2019
+
+import gdb
+
+from linux.utils import CachedType
+from linux.utils import container_of
+from linux.lists import list_for_each_entry
+
+
+device_private_type = CachedType('struct device_private')
+device_type = CachedType('struct device')
+
+subsys_private_type = CachedType('struct subsys_private')
+kobject_type = CachedType('struct kobject')
+kset_type = CachedType('struct kset')
+
+bus_type = CachedType('struct bus_type')
+class_type = CachedType('struct class')
+
+
+def dev_name(dev):
+    dev_init_name = dev['init_name']
+    if dev_init_name:
+        return dev_init_name.string()
+    return dev['kobj']['name'].string()
+
+
+def kset_for_each_object(kset):
+    return list_for_each_entry(kset['list'],
+            kobject_type.get_type().pointer(), "entry")
+
+
+def for_each_bus():
+    for kobj in kset_for_each_object(gdb.parse_and_eval('bus_kset')):
+        subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
+        subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
+        yield subsys_priv['bus']
+
+
+def for_each_class():
+    for kobj in kset_for_each_object(gdb.parse_and_eval('class_kset')):
+        subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
+        subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
+        yield subsys_priv['class']
+
+
+def get_bus_by_name(name):
+    for item in for_each_bus():
+        if item['name'].string() == name:
+            return item
+    raise gdb.GdbError("Can't find bus type {!r}".format(name))
+
+
+def get_class_by_name(name):
+    for item in for_each_class():
+        if item['name'].string() == name:
+            return item
+    raise gdb.GdbError("Can't find device class {!r}".format(name))
+
+
+klist_type = CachedType('struct klist')
+klist_node_type = CachedType('struct klist_node')
+
+
+def klist_for_each(klist):
+    return list_for_each_entry(klist['k_list'],
+                klist_node_type.get_type().pointer(), 'n_node')
+
+
+def bus_for_each_device(bus):
+    for kn in klist_for_each(bus['p']['klist_devices']):
+        dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_bus')
+        yield dp['device']
+
+
+def class_for_each_device(cls):
+    for kn in klist_for_each(cls['p']['klist_devices']):
+        dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_class')
+        yield dp['device']
+
+
+def device_for_each_child(dev):
+    for kn in klist_for_each(dev['p']['klist_children']):
+        dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_parent')
+        yield dp['device']
+
+
+def _show_device(dev, level=0, recursive=False):
+    gdb.write('{}dev {}:\t{}\n'.format('\t' * level, dev_name(dev), dev))
+    if recursive:
+        for child in device_for_each_child(dev):
+            _show_device(child, level + 1, recursive)
+
+
+class LxDeviceListBus(gdb.Command):
+    '''Print devices on a bus (or all buses if not specified)'''
+
+    def __init__(self):
+        super(LxDeviceListBus, self).__init__('lx-device-list-bus', gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        if not arg:
+            for bus in for_each_bus():
+                gdb.write('bus {}:\t{}\n'.format(bus['name'].string(), bus))
+                for dev in bus_for_each_device(bus):
+                    _show_device(dev, level=1)
+        else:
+            bus = get_bus_by_name(arg)
+            if not bus:
+                raise gdb.GdbError("Can't find bus {!r}".format(arg))
+            for dev in bus_for_each_device(bus):
+                _show_device(dev)
+
+
+class LxDeviceListClass(gdb.Command):
+    '''Print devices in a class (or all classes if not specified)'''
+
+    def __init__(self):
+        super(LxDeviceListClass, self).__init__('lx-device-list-class', gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        if not arg:
+            for cls in for_each_class():
+                gdb.write("class {}:\t{}\n".format(cls['name'].string(), cls))
+                for dev in class_for_each_device(cls):
+                    _show_device(dev, level=1)
+        else:
+            cls = get_class_by_name(arg)
+            for dev in class_for_each_device(cls):
+                _show_device(dev)
+
+
+class LxDeviceListTree(gdb.Command):
+    '''Print a device and its children recursively'''
+
+    def __init__(self):
+        super(LxDeviceListTree, self).__init__('lx-device-list-tree', gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        if not arg:
+            raise gdb.GdbError('Please provide pointer to struct device')
+        dev = gdb.parse_and_eval(arg)
+        if dev.type != device_type.get_type().pointer():
+            raise gdb.GdbError('Please provide pointer to struct device')
+        _show_device(dev, level=0, recursive=True)
+
+
+class LxDeviceFindByBusName(gdb.Function):
+    '''Find struct device by bus and name (both strings)'''
+
+    def __init__(self):
+        super(LxDeviceFindByBusName, self).__init__('lx_device_find_by_bus_name')
+
+    def invoke(self, bus, name):
+        name = name.string()
+        bus = get_bus_by_name(bus.string())
+        for dev in bus_for_each_device(bus):
+            if dev_name(dev) == name:
+                return dev
+
+
+class LxDeviceFindByClassName(gdb.Function):
+    '''Find struct device by class and name (both strings)'''
+
+    def __init__(self):
+        super(LxDeviceFindByClassName, self).__init__('lx_device_find_by_class_name')
+
+    def invoke(self, cls, name):
+        name = name.string()
+        cls = get_class_by_name(cls.string())
+        for dev in class_for_each_device(cls):
+            if dev_name(dev) == name:
+                return dev
+
+
+LxDeviceListBus()
+LxDeviceListClass()
+LxDeviceListTree()
+LxDeviceFindByBusName()
+LxDeviceFindByClassName()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index a504f511e752..4136dc2c59df 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -34,5 +34,6 @@ else:
     import linux.proc
     import linux.constants
     import linux.timerlist
     import linux.clk
     import linux.genpd
+    import linux.device
-- 
2.17.1

