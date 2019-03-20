Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4299C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19D72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qbW/+GhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfCTS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:29:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfCTS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:29:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KISwaR066807;
        Wed, 20 Mar 2019 18:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=SwH/l6jXqNIZfIo7XbroF1D9grWvrl3h19wwI04COw0=;
 b=qbW/+GhRNqc8dOdYJqL/mP9JERS0hrweZNqdNbwIPdDHDiSvygLIkvwnSEhZcpk1vlwQ
 TtxjbAi5FvSRyNI0QZNEgPg5zdviZiPe+AKmkVYEw63Bl7FOshWC08oLk+WwVCuC4Ub+
 KXRlYqVDQ4a0Vkn0NcXJhZrBYZz01q1tWNsCDZy1aH8rXE43n6WdabHIQNdARMjT3Urw
 JaBLtHQRxVNYtc6B3gxAoXgq88LiTLiMakJRmFMHCKVmCGOgf89UW+jfMWoTqqdylBQX
 8aiQQTJC+dEvnwkNJYlePJgECAZZy44zPa3B1y7xLCksL6JVG7CPevTA++pTsFZ+FasF 5Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssrmds7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:29:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2KIT5oe007066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:29:06 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2KIT5jh028397;
        Wed, 20 Mar 2019 18:29:05 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 11:29:05 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Jin <joe.jin@oracle.com>, Divya Indi <divya.indi@oracle.com>
Subject: [RFC] Kernel access to Ftrace instances. 
Date:   Wed, 20 Mar 2019 11:28:50 -0700
Message-Id: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] tracing: Kernel access to Ftrace instances.

Please review the patch that follows. Below are some details providing
the goal and justification for the patch.

=======================================================================

Goal:

Ftrace provides the feature “instances” that provides the capability to
create multiple Ftrace ring buffers. However, currently these buffers
are created/accessed via userspace only. The kernel APIs providing these
features are not exported, hence cannot be used by other kernel
components. We want to extend this infrastructure to provide the
flexibility to create/log/remove/ enable-disable existing trace events
to these buffers from within the kernel.


Justification:

     1. We need module-specific/use-case specific ring buffers (apart
from the global trace buffer) to avoid overwrite by other components.
Hence, the need to use Ftrace "instances".

     2. Flexibility to add additional logging to these module-specific
buffers via ksplice/live patch - Having a trace_printk counterpart for
these additional ring buffers.

     3. Most often certain issues and events can be best monitored
within kernel.

     4. Time sensitivity - We need the capability to dynamically enable
and disable tracing from within kernel to extract relevant debugging
info for the right time-window.


Example:

When the kernel detects an unexpected event such as connection drop (Eg:
RDS/NFS connection drops), we need the capability to enable specific
event tracing to capture relevant info during reconnect. This event
tracing will help us diagnose issues that occur during reconnect like
RCA longer reconnect times. In such cases we also want to disable the
tracing  at the right moment and capture a snapshot from within kernel
to make sure we have the relevant diagnostics data and nothing is
overwritten or lost.


Note: The additional logging is not part of the kernel. We intend to
only provide the flexibility to add the logging as part of diagnostics
via ksplice/live-patch on need-basis.


Please find below the compilation of APIs to be introduced or exported as is.


We propose adding two new functions:

1. struct trace_array *trace_array_create(const char *name);
2. int trace_array_destroy(struct trace_array *tr);


In addition, we need to export functions:

3. int trace_array_printk(struct trace_array *tr, unsigned long ip,
             const char *fmt, ...);
4. int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
5. void trace_printk_init_buffers(void);


To workaround the redundancy due to the newly introduced APIs, we propose the
following restructuring -

1. Move the contents of instance_mkdir to the new API.
static int instance_mkdir(const char *name)
{
     return PTR_ERR_OR_ZERO(trace_array_create(name));
}

2. Introduce internal static function: __remove_instance(struct trace_array *tr)
This will be almost similar to old instance_rmdir which
identified the trace_array to be removed based on the name.

Modify existing API to use the internal function:
static int instance_rmdir(const char *name)
{
     struct trace_array *tr;
     int err = -ENODEV;

     mutex_lock(&event_mutex);
     mutex_lock(&trace_types_lock);

     list_for_each_entry(tr, &ftrace_trace_arrays, list) {
         if (tr->name && strcmp(tr->name, name) == 0) {
             err = __remove_instance(tr);
             break;
         }
     }

     mutex_unlock(&trace_types_lock);
     mutex_unlock(&event_mutex);

     return err;
}

New API to be exported:
int trace_array_destroy(struct trace_array *tr)
{
     int err;

     mutex_lock(&event_mutex);
     mutex_lock(&trace_types_lock);
     err = __remove_instance(tr);
     mutex_unlock(&trace_types_lock);
     mutex_unlock(&event_mutex);

     return err;
}

====================================================================================

Thanks,
Divya 
