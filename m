Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8AC46470
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 05:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA502173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 05:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pCdZURrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfELFtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 01:49:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44376 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfELFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 01:49:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so6885038qtk.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6c2kvC33LANT/dMFRqDq0mJDA8htPkT69/GA1pevljE=;
        b=pCdZURrr3WKxmADSBzXKJit6CTquRKjG0USn5xohP+aXHtXE6fJV34WEWbwB+IYT+O
         HfPnj/7+lDpSUtKsV980fyNsbeTQBc09FmEcc4RmStWOU5+VwMdaDViISH0jqiBc+IPL
         a/GaDOsa7ksme2XwJ/SijZKsxwyIWYr7yyrUIT+Vf9nR7kl5BNg2+7RrHH2t3zxoZ5BL
         BDOXMz+8qZo+G7MM+gIH1yjSFTk/aKVZdkaIhP87QkjZkdUJNhRFBJDXP8fZHYnpjhts
         Q5TdnE1/coSvEIl4Aa7eepZO3AP2FQNKvbjflK8uOT14A4+BlBwyj03+HUhOLC8epeE/
         IeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6c2kvC33LANT/dMFRqDq0mJDA8htPkT69/GA1pevljE=;
        b=AP9r77SdP3MLG6Wi6V+gPLKnnEwDeN1GrNWBPyW9gKR+Z0wpssCcc7nBsF0Z53aiGD
         4pCUtWmh6Mg9FptECJNT4xh8t2G3ArZSEX4Y8A4jdeFbt9aIlL1rKOnWHZi3KgC8MqrE
         J+OUTPLqw5OdQ6b7nhg0JCWbAeYqXUc065ODLINBvfeju0J8Ke+xzv2v0QsmV9l24tCx
         BMN0fprpAhNmQ2u1muodV55e9ez3uIWsCfyu4x+6Vcstu+sE7Mk6szTM70AQoBpQGYjr
         poYxkWacFzuF0foguXp4rTy89jD09emkkmH/16xNBmpss6J0r1OPekRSk/WZyAj7Gqcx
         ODEg==
X-Gm-Message-State: APjAAAURESMvztxmiZBxKpyf6SEQH7G9II4F4ZA2xCKOyuXeNMX7Im+1
        6O5TAGVYenOE6ipOnBumcoELBw4ZA08=
X-Google-Smtp-Source: APXvYqzW8aSxY6OoX/5athcz/9TnyMOBrzXGyDz3abcE6/hG6s6QeFwc8YHtljDP9ZdUya6aMFrolw==
X-Received: by 2002:ac8:1609:: with SMTP id p9mr17580321qtj.291.1557640148921;
        Sat, 11 May 2019 22:49:08 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s17sm1751951qke.60.2019.05.11.22.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 22:49:07 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
Date:   Sun, 12 May 2019 01:48:29 -0400
Message-Id: <20190512054829.11899-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit ("x86, numa: always initialize all possible
nodes") introduced a crash below during boot for systems with a
memory-less node. This is due to CPUs that get onlined during SMP boot,
but that onlining triggers a page fault in bus_add_device() during
device registration:

	error = sysfs_create_link(&bus->p->devices_kset->kobj,

bus->p is NULL. That "p" is the subsys_private struct, and it should
have been set in,

	postcore_initcall(register_node_type);

but that happens in do_basic_setup() after smp_init().

The old code had set this node online via alloc_node_data(), so when it
came time to do_cpu_up() -> try_online_node(), the node was already up
and nothing happened.

Now, it attempts to online the node, which registers the node with
sysfs, but that can't happen before the 'node' subsystem is registered.

Since kernel_init() is running by a kernel thread that is in
SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
during the early boot in __try_online_node().

Call Trace:
 device_add+0x43e/0x690
 device_register+0x107/0x110
 __register_one_node+0x72/0x150
 __try_online_node+0x8f/0xd0
 try_online_node+0x2b/0x50
 do_cpu_up+0x46/0xf0
 cpu_up+0x13/0x20
 smp_init+0x6e/0xd0
 kernel_init_freeable+0xe5/0x21f
 kernel_init+0xf/0x180
 ret_from_fork+0x1f/0x30

Reported-by: Barret Rhoden <brho@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Set the node online as it have CPUs. Otherwise, those memory-less nodes will
    end up being not in sysfs i.e., /sys/devices/system/node/.

 mm/memory_hotplug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b236069ff0d8..6eb2331fa826 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1037,6 +1037,18 @@ static int __try_online_node(int nid, u64 start, bool set_node_online)
 	if (node_online(nid))
 		return 0;
 
+	/*
+	 * Here is called by cpu_up() to online a node without memory from
+	 * kernel_init() which guarantees that "set_node_online" is true which
+	 * will set the node online as it have CPUs but not ready to call
+	 * register_one_node() as "node_subsys" has not been initialized
+	 * properly yet.
+	 */
+	if (system_state == SYSTEM_SCHEDULING) {
+		node_set_online(nid);
+		return 0;
+	}
+
 	pgdat = hotadd_new_pgdat(nid, start);
 	if (!pgdat) {
 		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
-- 
2.20.1 (Apple Git-117)

