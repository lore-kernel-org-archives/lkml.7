Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F259214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VL9uFKtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfCLRnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:43:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfCLRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CHEJXU126442;
        Tue, 12 Mar 2019 17:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kqgYdMMnC1rX4Pe0Vj248e1LbMDASl3aQnMtGJJOrv0=;
 b=VL9uFKtISELnRNlRemBF35Al1+vx1gnRI6cmmIhzNXaeqLOVxSWSH40iZ/QWB+3fGKbB
 qXmpG9FGyuFdNL6rH7MoXft5ypl1nf7tLonT0cHysrQNtamR9DvxeQNbi0Yv0bXXw2qc
 6DF9d9vw9L9L6KzhFnYK1cDed8h/VE4dP99Jx4SV4nXiDLlyZwqhUVJNfy0lGmRy2zwK
 XQ8899+vVWonZXrzYD2sX8Qh1QgmcsovVO0DwEozWIZkvFp1I4cXtYAmWBiUJEiLNNzI
 K4+kXJw8eK06YrR5/O9LdCuGOt4zsYgrA3BCYg3KJkoVVdV0/HZ6ulZyrocl2soNWeht Ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r464re2mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 17:14:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2CHEweW031622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 17:14:58 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2CHEvrJ021638;
        Tue, 12 Mar 2019 17:14:57 GMT
Received: from [10.175.188.73] (/10.175.188.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 10:14:57 -0700
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
 <8b1f4912-4f92-69ae-ae01-d899d5640572@oracle.com>
 <3ee91f33-2973-c2db-386f-afbf138081b4@redhat.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <59676804-786d-3df8-7752-8e45dec6d65b@oracle.com>
Date:   Tue, 12 Mar 2019 17:14:50 +0000
MIME-Version: 1.0
In-Reply-To: <3ee91f33-2973-c2db-386f-afbf138081b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 4:59 PM, Paolo Bonzini wrote:
> On 21/02/19 12:45, Joao Martins wrote:
>> On 2/20/19 9:09 PM, Paolo Bonzini wrote:
>>> On 20/02/19 21:15, Joao Martins wrote:
>>>>  2. PV Driver support (patches 17 - 39)
>>>>
>>>>  We start by redirecting hypercalls from the backend to routines
>>>>  which emulate the behaviour that PV backends expect i.e. grant
>>>>  table and interdomain events. Next, we add support for late
>>>>  initialization of xenbus, followed by implementing
>>>>  frontend/backend communication mechanisms (i.e. grant tables and
>>>>  interdomain event channels). Finally, introduce xen-shim.ko,
>>>>  which will setup a limited Xen environment. This uses the added
>>>>  functionality of Xen specific shared memory (grant tables) and
>>>>  notifications (event channels).
>>>
>>> I am a bit worried by the last patches, they seem really brittle and
>>> prone to breakage.  I don't know Xen well enough to understand if the
>>> lack of support for GNTMAP_host_map is fixable, but if not, you have to
>>> define a completely different hypercall.
>>>
>> I guess Ankur already answered this; so just to stack this on top of his comment.
>>
>> The xen_shim_domain() is only meant to handle the case where the backend
>> has/can-have full access to guest memory [i.e. netback and blkback would work
>> with similar assumptions as vhost?]. For the normal case, where a backend *in a
>> guest* maps and unmaps other guest memory, this is not applicable and these
>> changes don't affect that case.
>>
>> IOW, the PV backend here sits on the hypervisor, and the hypercalls aren't
>> actual hypercalls but rather invoking shim_hypercall(). The call chain would go
>> more or less like:
>>
>> <netback|blkback|scsiback>
>>  gnttab_map_refs(map_ops, pages)
>>    HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
>>      shim_hypercall()
>>        shim_hcall_gntmap()
>>
>> Our reasoning was that given we are already in KVM, why mapping a page if the
>> user (i.e. the kernel PV backend) is himself? The lack of GNTMAP_host_map is how
>> the shim determines its user doesn't want to map the page. Also, there's another
>> issue where PV backends always need a struct page to reference the device
>> inflight data as Ankur pointed out.
> 
> Ultimately it's up to the Xen people.  It does make their API uglier,
> especially the in/out change for the parameter.  If you can at least
> avoid that, it would alleviate my concerns quite a bit.

In my view, we have two options overall:

1) Make it explicit, the changes the PV drivers we have to make in
order to support xen_shim_domain(). This could mean e.g. a) add a callback
argument to gnttab_map_refs() that is invoked for every page that gets looked up
successfully, and inside this callback the PV driver may update it's tracking
page. Here we no longer have this in/out parameter in gnttab_map_refs, and all
shim_domain specific bits would be a little more abstracted from Xen PV
backends. See netback example below the scissors mark. Or b) have sort of a
translate_gref() and put_gref() API that Xen PV drivers use which make it even
more explicit that there's no grant ops involved. The latter is more invasive.

2) The second option is to support guest grant mapping/unmapping [*] to allow
hosting PV backends inside the guest. This would remove the Xen changes in this
series completely. But it would require another guest being used
as netback/blkback/xenstored, and less performance than 1) (though, in theory,
it would be equivalent to what does Xen with grants/events). The only changes in
Linux Xen code is adding xenstored domain support, but that is useful on its own
outside the scope of this work.

I think there's value on both; 1) is probably more familiar for KVM users
perhaps (as it is similar to what vhost does?) while  2) equates to implementing
Xen disagregation capabilities in KVM.

Thoughts? Xen maintainers what's your take on this?

	Joao

[*] Interdomain events would also have to change.

---------------- >8 ----------------

It isn't much cleaner, but PV drivers avoid/hide a bunch of xen_shim_domain()
conditionals in the data path. It is more explicit while avoiding the in/out
parameter change in gnttab_map_refs.

diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 936c0b3e0ba2..c6e47dcb7e10 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -158,6 +158,7 @@ struct xenvif_queue { /* Per-queue data for xenvif */
 	struct gnttab_copy tx_copy_ops[MAX_PENDING_REQS];
 	struct gnttab_map_grant_ref tx_map_ops[MAX_PENDING_REQS];
 	struct gnttab_unmap_grant_ref tx_unmap_ops[MAX_PENDING_REQS];
+	struct gnttab_page_changed page_cb[MAX_PENDING_REQS];
 	/* passed to gnttab_[un]map_refs with pages under (un)mapping */
 	struct page *pages_to_map[MAX_PENDING_REQS];
 	struct page *pages_to_unmap[MAX_PENDING_REQS];
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a32c2a..56788d8cd813 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -324,15 +324,29 @@ struct xenvif_tx_cb {

 #define XENVIF_TX_CB(skb) ((struct xenvif_tx_cb *)(skb)->cb)

+static inline void xenvif_tx_page_changed(phys_addr_t addr, void *opaque)
+{
+	struct page **page = opaque;
+
+	*page = virt_to_page(addr);
+}
 static inline void xenvif_tx_create_map_op(struct xenvif_queue *queue,
 					   u16 pending_idx,
 					   struct xen_netif_tx_request *txp,
 					   unsigned int extra_count,
 					   struct gnttab_map_grant_ref *mop)
 {
-	queue->pages_to_map[mop-queue->tx_map_ops] = queue->mmap_pages[pending_idx];
+	u32 map_idx = mop - queue->tx_map_ops;
+
+	queue->pages_to_map[map_idx] = queue->mmap_pages[pending_idx];
+	queue->page_cb[map_idx].ctx = &queue->mmap_pages[pending_idx];
+	queue->page_cb[map_idx].cb = xenvif_tx_page_changed;
+
 	gnttab_set_map_op(mop, idx_to_kaddr(queue, pending_idx),
-			  GNTMAP_host_map | GNTMAP_readonly,
+			  GNTTAB_host_map | GNTMAP_readonly,
 			  txp->gref, queue->vif->domid);

 	memcpy(&queue->pending_tx_info[pending_idx].req, txp,
@@ -1268,7 +1283,7 @@ static inline void xenvif_tx_dealloc_action(struct
xenvif_queue *queue)
 				queue->mmap_pages[pending_idx];
 			gnttab_set_unmap_op(gop,
 					    idx_to_kaddr(queue, pending_idx),
-					    GNTMAP_host_map,
+					    GNTTAB_host_map,
 					    queue->grant_tx_handle[pending_idx]);
 			xenvif_grant_handle_reset(queue, pending_idx);
 			++gop;
@@ -1322,7 +1337,7 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 	gnttab_batch_copy(queue->tx_copy_ops, nr_cops);
 	if (nr_mops != 0) {
 		ret = gnttab_map_refs(queue->tx_map_ops,
-				      NULL,
+				      NULL, queue->page_cb,
 				      queue->pages_to_map,
 				      nr_mops);
 		BUG_ON(ret);
@@ -1394,7 +1409,7 @@ void xenvif_idx_unmap(struct xenvif_queue *queue, u16
pending_idx)

 	gnttab_set_unmap_op(&tx_unmap_op,
 			    idx_to_kaddr(queue, pending_idx),
-			    GNTMAP_host_map,
+			    GNTTAB_host_map,
 			    queue->grant_tx_handle[pending_idx]);
 	xenvif_grant_handle_reset(queue, pending_idx);

@@ -1622,7 +1637,7 @@ static int __init netback_init(void)
 {
 	int rc = 0;

-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;

 	/* Allow as many queues as there are CPUs but max. 8 if user has not
@@ -1663,6 +1678,7 @@ static void __exit netback_fini(void)
 	debugfs_remove_recursive(xen_netback_dbg_root);
 #endif /* CONFIG_DEBUG_FS */
 	xenvif_xenbus_fini();
+	xen_shim_domain_put();
 }
 module_exit(netback_fini);

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7ea6fb6a2e5d..b4c9d7ff531f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1031,6 +1031,7 @@ void gnttab_foreach_grant(struct page **pages,

 int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
+		    struct gnttab_page_changed *page_cb,
 		    struct page **pages, unsigned int count)
 {
 	int i, ret;
@@ -1045,6 +1046,12 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		{
 			struct xen_page_foreign *foreign;

+			if (xen_shim_domain() && page_cb) {
+				page_cb[i].cb(map_ops[i].host_addr,
+					      page_cb[i].ctx);
+				continue;
+			}
+
 			SetPageForeign(pages[i]);
 			foreign = xen_page_foreign(pages[i]);
 			foreign->domid = map_ops[i].dom;
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 9bc5bc07d4d3..5e17fa08e779 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -55,6 +55,9 @@
 /* NR_GRANT_FRAMES must be less than or equal to that configured in Xen */
 #define NR_GRANT_FRAMES 4

+/* Selects host map only if on native Xen */
+#define GNTTAB_host_map (xen_shim_domain() ? 0 : GNTMAP_host_map)
+
 struct gnttab_free_callback {
 	struct gnttab_free_callback *next;
 	void (*fn)(void *);
@@ -78,6 +81,12 @@ struct gntab_unmap_queue_data
 	unsigned int age;
 };

+struct gnttab_page_changed
+{
+	void (*cb)(phys_addr_t addr, void *opaque);
+	void *ctx;
+};
+
 int gnttab_init(void);
 int gnttab_suspend(void);
 int gnttab_resume(void);
@@ -221,6 +230,7 @@ void gnttab_pages_clear_private(int nr_pages, struct page
**pages);

 int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
+		    struct gnttab_page_changed *cb,
 		    struct page **pages, unsigned int count);
 int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
 		      struct gnttab_unmap_grant_ref *kunmap_ops,
