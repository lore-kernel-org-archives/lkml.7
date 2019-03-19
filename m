Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386E3206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCSQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:42:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfCSQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4118AED8;
        Tue, 19 Mar 2019 16:42:25 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan\, Zheng" <ukernel@gmail.com>
Cc:     "Yan\, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
References: <20190312142019.30936-1-lhenriques@suse.com>
        <20190312142019.30936-3-lhenriques@suse.com>
        <CAAM7YAkksn_w6Nsm0D7HVGh59ysAJyHptXQ886xD9DAVGhxNEQ@mail.gmail.com>
Date:   Tue, 19 Mar 2019 16:42:24 +0000
In-Reply-To: <CAAM7YAkksn_w6Nsm0D7HVGh59ysAJyHptXQ886xD9DAVGhxNEQ@mail.gmail.com>
        (Zheng Yan's message of "Mon, 18 Mar 2019 21:06:28 +0800")
Message-ID: <8736nin7db.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Tue, Mar 12, 2019 at 10:22 PM Luis Henriques <lhenriques@suse.com> wrote:
...
>> +static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
>> +                                            struct super_block *sb,
>> +                                            struct ceph_snap_realm *realm)
>> +{
>> +       struct inode *in;
>> +
>> +       in = ceph_lookup_inode(sb, realm->ino);
>> +       if (IS_ERR(in)) {
>> +               pr_warn("Can't lookup inode %llx (err: %ld)\n",
>> +                       realm->ino, PTR_ERR(in));
>> +               return in;
>> +       }
>> +
>> +       spin_lock(&mdsc->quotarealms_inodes_lock);
>> +       list_add(&ceph_inode(in)->i_quotarealms_inode_item,
>> +                &mdsc->quotarealms_inodes_list);
>> +       spin_unlock(&mdsc->quotarealms_inodes_lock);
>> +
> Multiple threads can call this function for the same inode at the same
> time. need to handle this. Besides, client needs to record lookupino
> error. Otherwise, client may repeatedly send useless request.

Good point.  So, the only way I see to fix this is to drop the
mdsc->quotarealms_inodes_list and instead use an ordered list/tree of
structs that would either point to the corresponding ceph inode or to
NULL if there was an error in the lookup:

	struct ceph_realm_inode {
                u64 ino;
		struct ceph_inode_info *ci;
		spinlock_t lock;
		unsigned long timeout;
	}

The 'timeout' field would be used to try to do the lookup again if the
error occurred long time ago.

The code would then create a new struct for the realm->ino (if one is
not found in the mdsc list), lock it and do the lookupino; if there's a
struct already on the list, it either means there's a lookupino in
progress or there was an error in the last lookup.

This sounds overly complicated so I may be missing the obvious simple
fix.  Any ideas?

>> +       spin_lock(&realm->inodes_with_caps_lock);
>> +       realm->inode = in;
>
> reply of lookup_ino should alreadly set realm->inode

Yes, of course.  This was silly.

Cheers,
-- 
Luis
