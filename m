Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3B32083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Wwr+QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDLKYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:24:33 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52635 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDLKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:24:33 -0400
Received: by mail-wm1-f53.google.com with SMTP id a184so10550035wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ka45ptmGyQFzPQ5cdN3bD2WYbbrHjTtlr0Y6HP683ec=;
        b=h3Wwr+QU181Yg8fgTodgGsCWi+F4vA4L3DWOCrWJulx9Na9nYxwjhllJb8AUvfRoW+
         Fp+8HI4DBp1lBgA9iIOXUxMjLtp0MNdJCGlJfJXgG2jYmZ+CtbZkmV4oIF57OBoclDIa
         YTfI8V4eXTGtHOv/OBmDzWD0e7u9hr+UTgoMNpjVNd7dlJYv6BMykSBIESe8EBqZ6gvu
         PbWOHLDJahxDXOVBMrvWS1E+o1xFe3HXYa4B09kbyJJRXVT+6vAu5Vz+SKgcx8QAeqX5
         0j+/DnWBtxQv6ubILhy2v/it/loo/Na4WUjl/rTsM9uqeR3vUfiv6QY9K5A5QZ0PmRZ/
         HMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ka45ptmGyQFzPQ5cdN3bD2WYbbrHjTtlr0Y6HP683ec=;
        b=lZpeP/uKuYS7vUYqwdjbovW1hB+8Bi+Zu8KTRJQkFRsV5jR9xUW2T1VcKHHsFlmSFK
         isxIEo+OX1uDcMur8p/JjyCjh3KE6P+6F4DbN/tPFq67OOT4jyL94mIITGar5XSFz6DQ
         88adzqfeyn1PEwmLAhWNxr1lROOAJDb/MRWF0vhxdi9kjDp+rNlSi4F3jjs9/TM/7lm4
         4pXqiegH0wU0PnBse6+LihxpUDA3+xv/m0bbiQif8V00wbYID+qngti5fM01BGG66wgm
         1Yp81b8QwU+OS58qEiVno64c2J2yw/UBo1rtuXzMnK72yc75WwWvEUOjuFmd0vX0Imwn
         GtOA==
X-Gm-Message-State: APjAAAVUQ8Yu282HIsfVsGWJloVO07b8Tv69YmQ4AOucfyaOlWAY2mxE
        x9hF+M5J8eyEve8UpYUIl9EtMCNa
X-Google-Smtp-Source: APXvYqzYLAEiSknJxFxsh4o4vl6QoOvqvEtzhgVGrWlpBUuXYayI6ca0z6Gz42d36GYqbr79hm+TBA==
X-Received: by 2002:a1c:a803:: with SMTP id r3mr9710125wme.78.1555064670837;
        Fri, 12 Apr 2019 03:24:30 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id i28sm114194260wrc.32.2019.04.12.03.24.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 03:24:30 -0700 (PDT)
Date:   Fri, 12 Apr 2019 12:24:18 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] clang-format: Update with the latest for_each macro list
Message-ID: <20190412102418.GA12679@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-run the shell fragment that generated the original list now that
there are two dozens of new entries after v5.1's merge window.
---
Sending this as a PR for the next -rc.

 .clang-format | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/.clang-format b/.clang-format
index f49620f506f1..f3923a1f9858 100644
--- a/.clang-format
+++ b/.clang-format
@@ -78,6 +78,8 @@ ForEachMacros:
   - 'ata_qc_for_each_with_internal'
   - 'ax25_for_each'
   - 'ax25_uid_for_each'
+  - '__bio_for_each_bvec'
+  - 'bio_for_each_bvec'
   - 'bio_for_each_integrity_vec'
   - '__bio_for_each_segment'
   - 'bio_for_each_segment'
@@ -118,10 +120,12 @@ ForEachMacros:
   - 'drm_for_each_legacy_plane'
   - 'drm_for_each_plane'
   - 'drm_for_each_plane_mask'
+  - 'drm_for_each_privobj'
   - 'drm_mm_for_each_hole'
   - 'drm_mm_for_each_node'
   - 'drm_mm_for_each_node_in_range'
   - 'drm_mm_for_each_node_safe'
+  - 'flow_action_for_each'
   - 'for_each_active_drhd_unit'
   - 'for_each_active_iommu'
   - 'for_each_available_child_of_node'
@@ -158,6 +162,9 @@ ForEachMacros:
   - 'for_each_dss_dev'
   - 'for_each_efi_memory_desc'
   - 'for_each_efi_memory_desc_in_map'
+  - 'for_each_element'
+  - 'for_each_element_extid'
+  - 'for_each_element_id'
   - 'for_each_endpoint_of_node'
   - 'for_each_evictable_lru'
   - 'for_each_fib6_node_rt_rcu'
@@ -195,6 +202,7 @@ ForEachMacros:
   - 'for_each_net_rcu'
   - 'for_each_new_connector_in_state'
   - 'for_each_new_crtc_in_state'
+  - 'for_each_new_mst_mgr_in_state'
   - 'for_each_new_plane_in_state'
   - 'for_each_new_private_obj_in_state'
   - 'for_each_node'
@@ -210,8 +218,10 @@ ForEachMacros:
   - 'for_each_of_pci_range'
   - 'for_each_old_connector_in_state'
   - 'for_each_old_crtc_in_state'
+  - 'for_each_old_mst_mgr_in_state'
   - 'for_each_oldnew_connector_in_state'
   - 'for_each_oldnew_crtc_in_state'
+  - 'for_each_oldnew_mst_mgr_in_state'
   - 'for_each_oldnew_plane_in_state'
   - 'for_each_oldnew_plane_in_state_reverse'
   - 'for_each_oldnew_private_obj_in_state'
@@ -243,6 +253,9 @@ ForEachMacros:
   - 'for_each_sg_dma_page'
   - 'for_each_sg_page'
   - 'for_each_sibling_event'
+  - 'for_each_subelement'
+  - 'for_each_subelement_extid'
+  - 'for_each_subelement_id'
   - '__for_each_thread'
   - 'for_each_thread'
   - 'for_each_zone'
@@ -252,6 +265,8 @@ ForEachMacros:
   - 'fwnode_for_each_child_node'
   - 'fwnode_graph_for_each_endpoint'
   - 'gadget_for_each_ep'
+  - 'genradix_for_each'
+  - 'genradix_for_each_from'
   - 'hash_for_each'
   - 'hash_for_each_possible'
   - 'hash_for_each_possible_rcu'
@@ -293,7 +308,11 @@ ForEachMacros:
   - 'key_for_each'
   - 'key_for_each_safe'
   - 'klp_for_each_func'
+  - 'klp_for_each_func_safe'
+  - 'klp_for_each_func_static'
   - 'klp_for_each_object'
+  - 'klp_for_each_object_safe'
+  - 'klp_for_each_object_static'
   - 'kvm_for_each_memslot'
   - 'kvm_for_each_vcpu'
   - 'list_for_each'
@@ -324,6 +343,8 @@ ForEachMacros:
   - 'media_device_for_each_intf'
   - 'media_device_for_each_link'
   - 'media_device_for_each_pad'
+  - 'mp_bvec_for_each_page'
+  - 'mp_bvec_for_each_segment'
   - 'nanddev_io_for_each_page'
   - 'netdev_for_each_lower_dev'
   - 'netdev_for_each_lower_private'
@@ -375,6 +396,7 @@ ForEachMacros:
   - 'rht_for_each_rcu'
   - 'rht_for_each_rcu_continue'
   - '__rq_for_each_bio'
+  - 'rq_for_each_bvec'
   - 'rq_for_each_segment'
   - 'scsi_for_each_prot_sg'
   - 'scsi_for_each_sg'
@@ -410,6 +432,8 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_src_buf_safe'
   - 'virtio_device_for_each_vq'
   - 'xa_for_each'
+  - 'xa_for_each_marked'
+  - 'xa_for_each_start'
   - 'xas_for_each'
   - 'xas_for_each_conflict'
   - 'xas_for_each_marked'
-- 
2.17.1

