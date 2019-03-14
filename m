Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E626C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNB7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:59:03 -0400
Received: from mx.sdf.org ([205.166.94.20]:65167 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfCNB7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:59:03 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2E1wibf011092
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 14 Mar 2019 01:58:44 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2E1wgFQ018649;
        Thu, 14 Mar 2019 01:58:42 GMT
Date:   Thu, 14 Mar 2019 01:58:42 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903140158.x2E1wgFQ018649@sdf.org>
To:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
Subject: Re: [PATCH 5/5] lib/list_sort: Optimize number of calls to comparison function
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
In-Reply-To: <dd8924c1-07a9-4317-bfa8-23271b138a62@rasmusvillemoes.dk>
References: <cover.1552097842.git.lkml@sdf.org>,
    <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>,
    <dd8924c1-07a9-4317-bfa8-23271b138a62@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 at 00:28:16 +0100, Rasmus Villemoes wrote:
> On 05/03/2019 06.58, George Spelvin wrote:
>> This patch avoids badly unbalanced merges on unlucky input sizes.
>> It slightly increases the code size, but saves an average of 0.2*n
>> calls to cmp().
>> 
> [snip]
>> 
>> (I confess to being more than a little bit proud of how clean this
>> code turned out.  It took a lot of thinking, but the resultant inner
>> loop is very simple and efficient.)
>
> This is beautiful. So no comments on the patch itself. One thing that
> might be nice would be to see the reduction in number of cmp callbacks
> explicitly; it should be trivial to use the priv element for that in the
> list_sort_test module. But to really see it one would of course have to
> extend that test to do a lot more different sizes of lists.

And you'd have to compile and run two different kernels, because you
can't run the algorithms side-by-side.  Not a good way to do it.

I used a user-space test harness for testing.  The output is ugly,
but here are lots of numbers for various list sizes.

The first group is single sort invocations.  The list is sorted by
(random) key, then again by address (the inverse), and the number
of comparisons printed.  The numbers in parens are the linear
coefficient K in
	comparisons = n*log2(n) - K*n,
i.e. it's
	log2(n) - (comparisons / n).
Higher is better.

The three lines for each size are the original list_sort, a top-down
version I wrote as a "perfect" value for reference, and the posted
code.  (1034 and 1040 are particularly bad cases for the old code.)

1: 0 (0.000000) 0 (0.000000)
1: 0 (0.000000) 0 (0.000000)
1: 0 (0.000000) 0 (0.000000)
2: 1 (0.500000) 1 (0.500000)
2: 1 (0.500000) 1 (0.500000)
2: 1 (0.500000) 1 (0.500000)
3: 3 (0.584963) 3 (0.584963)
3: 2 (0.918296) 2 (0.918296)
3: 3 (0.584963) 3 (0.584963)
4: 5 (0.750000) 5 (0.750000)
4: 5 (0.750000) 5 (0.750000)
4: 5 (0.750000) 5 (0.750000)
5: 8 (0.721928) 8 (0.721928)
5: 8 (0.721928) 8 (0.721928)
5: 8 (0.721928) 8 (0.721928)
6: 10 (0.918296) 10 (0.918296)
6: 10 (0.918296) 10 (0.918296)
6: 10 (0.918296) 10 (0.918296)
7: 11 (1.235926) 12 (1.093069)
7: 13 (0.950212) 12 (1.093069)
7: 11 (1.235926) 12 (1.093069)
8: 17 (0.875000) 17 (0.875000)
8: 17 (0.875000) 17 (0.875000)
8: 17 (0.875000) 17 (0.875000)
9: 18 (1.169925) 22 (0.725481)
9: 21 (0.836592) 20 (0.947703)
9: 20 (0.947703) 20 (0.947703)
10: 20 (1.321928) 25 (0.821928)
10: 25 (0.821928) 24 (0.921928)
10: 22 (1.121928) 24 (0.921928)
13: 35 (1.008132) 35 (1.008132)
13: 33 (1.161978) 33 (1.161978)
13: 36 (0.931209) 35 (1.008132)
21: 71 (1.011365) 74 (0.868508)
21: 68 (1.154222) 71 (1.011365)
21: 69 (1.106603) 72 (0.963746)
31: 117 (1.180003) 111 (1.373551)
31: 114 (1.276777) 114 (1.276777)
31: 117 (1.180003) 111 (1.373551)
32: 123 (1.156250) 121 (1.218750)
32: 123 (1.156250) 121 (1.218750)
32: 123 (1.156250) 121 (1.218750)
33: 158 (0.256515) 149 (0.529243)
33: 130 (1.105000) 131 (1.074697)
33: 131 (1.074697) 131 (1.074697)
34: 142 (0.910992) 135 (1.116875)
34: 133 (1.175698) 135 (1.116875)
34: 131 (1.234522) 134 (1.146286)
55: 244 (1.344996) 249 (1.254087)
55: 246 (1.308632) 241 (1.399542)
55: 249 (1.254087) 250 (1.235905)
89: 484 (1.037531) 490 (0.970115)
89: 464 (1.262250) 477 (1.116183)
89: 479 (1.093711) 482 (1.060003)
127: 729 (1.248527) 727 (1.264275)
127: 734 (1.209157) 724 (1.287897)
127: 729 (1.248527) 727 (1.264275)
128: 744 (1.187500) 733 (1.273438)
128: 744 (1.187500) 733 (1.273438)
128: 744 (1.187500) 733 (1.273438)
129: 752 (1.181770) 853 (0.398824)
129: 746 (1.228282) 740 (1.274793)
129: 747 (1.220530) 741 (1.267041)
144: 926 (0.739369) 928 (0.725481)
144: 851 (1.260203) 866 (1.156036)
144: 865 (1.162981) 872 (1.114369)
233: 1556 (1.186075) 1541 (1.250452)
233: 1545 (1.233285) 1527 (1.310538)
233: 1550 (1.211826) 1534 (1.280495)
377: 2787 (1.165848) 2790 (1.157890)
377: 2752 (1.258686) 2771 (1.208288)
377: 2778 (1.189720) 2782 (1.179110)
610: 5115 (0.867420) 5115 (0.867420)
610: 4891 (1.234633) 4883 (1.247747)
610: 4909 (1.205124) 4930 (1.170698)
642: 5385 (0.938579) 5428 (0.871601)
642: 5166 (1.279701) 5185 (1.250105)
642: 5205 (1.218953) 5201 (1.225183)
987: 8574 (1.259976) 8620 (1.213370)
987: 8564 (1.270108) 8599 (1.234647)
987: 8565 (1.269095) 8614 (1.219449)
1022: 8937 (1.252561) 8913 (1.276044)
1022: 8916 (1.273109) 8928 (1.261367)
1022: 8937 (1.252561) 8913 (1.276044)
1023: 8959 (1.241015) 8909 (1.289891)
1023: 8927 (1.272295) 8918 (1.281093)
1023: 8959 (1.241015) 8909 (1.289891)
1024: 8970 (1.240234) 8916 (1.292969)
1024: 8966 (1.244141) 8912 (1.296875)
1024: 8966 (1.244141) 8912 (1.296875)
1025: 9548 (0.686286) 9724 (0.514579)
1025: 8971 (1.249213) 8943 (1.276530)
1025: 8970 (1.250189) 8944 (1.275555)
1026: 9771 (0.479423) 9745 (0.504764)
1026: 8936 (1.293263) 8978 (1.252328)
1026: 8942 (1.287415) 8993 (1.237708)
1028: 9643 (0.625274) 9985 (0.292590)
1028: 8980 (1.270216) 9006 (1.244924)
1028: 8980 (1.270216) 9005 (1.245897)
1032: 9894 (0.424018) 10004 (0.317429)
1032: 9024 (1.267041) 9028 (1.263165)
1032: 9011 (1.279638) 9056 (1.236033)
1033: 9885 (0.443409) 9875 (0.453089)
1033: 9016 (1.284648) 9022 (1.278839)
1033: 9049 (1.252702) 9034 (1.267223)
1034: 9974 (0.367986) 9936 (0.404736)
1034: 9052 (1.259668) 9071 (1.241293)
1034: 9054 (1.257734) 9065 (1.247096)
1040: 10019 (0.388714) 9845 (0.556022)
1040: 9108 (1.264676) 9069 (1.302176)
1040: 9124 (1.249291) 9046 (1.324291)
1056: 10130 (0.451591) 10142 (0.440227)
1056: 9276 (1.260303) 9269 (1.266932)
1056: 9301 (1.236629) 9317 (1.221477)
1088: 10275 (0.643529) 10321 (0.601250)
1088: 9585 (1.277720) 9608 (1.256580)
1088: 9616 (1.249228) 9634 (1.232683)
1152: 10855 (0.747182) 10844 (0.756731)
1152: 10295 (1.233293) 10282 (1.244578)
1152: 10347 (1.188154) 10331 (1.202043)
1280: 11940 (0.993803) 11931 (1.000834)
1280: 11571 (1.282084) 11581 (1.274272)
1280: 11683 (1.194584) 11673 (1.202397)
1365: 12807 (1.032268) 12844 (1.005161)
1365: 12523 (1.240326) 12523 (1.240326)
1365: 12589 (1.191975) 12624 (1.166334)
1597: 15314 (1.051919) 15350 (1.029377)
1597: 15044 (1.220986) 15011 (1.241650)
1597: 15056 (1.213472) 15083 (1.196565)
2584: 27102 (0.847000) 27008 (0.883378)
2584: 26106 (1.232449) 26022 (1.264957)
2584: 26246 (1.178270) 26155 (1.213486)
4181: 48583 (0.409685) 48614 (0.402270)
4181: 45056 (1.253263) 45060 (1.252306)
4181: 45034 (1.258525) 45071 (1.249675)
6765: 78516 (1.117666) 78482 (1.122692)
6765: 77657 (1.244643) 77675 (1.241982)
6765: 77954 (1.200740) 77910 (1.207245)
16383: 208649 (1.264210) 208758 (1.257557)
16383: 208715 (1.260182) 208783 (1.256031)
16383: 208649 (1.264210) 208758 (1.257557)
16384: 208712 (1.261230) 208665 (1.264099)
16384: 208648 (1.265137) 208601 (1.268005)
16384: 208648 (1.265137) 208601 (1.268005)
16385: 217320 (0.736737) 215597 (0.841895)
16385: 208608 (1.268443) 208694 (1.263195)
16385: 208608 (1.268443) 208693 (1.263256)

This next group are averages over a large number of sorts in
power-of-2 size ranges.  (Note that the number of sorts is
2*repeat*range, because again I'm sorting 2x per example.)

(Sort #2 is the version from patch #4, which performs identically
to #1, and #3 was an in-development version.)

Sum for range 3..4:  (repeat = 4096)
Total1: 59965 (1.349885)
Total4: 60022 (1.348725)
Total5: 59965 (1.349885)
Sum for range 5..8:  (repeat = 2048)
Total1: 188025 (1.260878)
Total4: 186220 (1.281908)
Total5: 186778 (1.276100)
Sum for range 9..16:  (repeat = 1024)
Total1: 535651 (1.202479)
Total4: 526451 (1.257404)
Total5: 528574 (1.246141)
Sum for range 17..32:  (repeat = 512)
Total1: 1425426 (1.154977)
Total4: 1393173 (1.250729)
Total5: 1401257 (1.229850)
Sum for range 33..64:  (repeat = 256)
Total1: 3600379 (1.114953)
Total4: 3511299 (1.248298)
Total5: 3530978 (1.222512)
Sum for range 65..128:  (repeat = 128)
Total1: 8747092 (1.080758)
Total4: 8522794 (1.248781)
Total5: 8572107 (1.216567)
Sum for range 129..256:  (repeat = 64)
Total1: 20628339 (1.055123)
Total4: 20112497 (1.248378)
Total5: 20220855 (1.212965)
Sum for range 257..512:  (repeat = 32)
Total1: 47548848 (1.038531)
Total4: 46428338 (1.248514)
Total5: 46656950 (1.211016)
Sum for range 513..1024:  (repeat = 16)
Total1: 107716456 (1.026297)
Total4: 105346353 (1.248269)
Total5: 105818923 (1.209578)
Sum for range 1025..2048:  (repeat = 8)
Total1: 240657666 (1.018584)
Total4: 235753284 (1.248303)
Total5: 236715946 (1.208852)
Sum for range 2049..4096:  (repeat = 4)
Total1: 531747462 (1.013639)
Total4: 521718711 (1.248403)
Total5: 523663717 (1.208580)
Sum for range 4097..8192:  (repeat = 2)
Total1: 1164325820 (1.010319)
Total4: 1143994299 (1.248290)
Total5: 1147896676 (1.208329)
Sum for range 8193..16384:  (repeat = 1)
Total1: 2530151423 (1.008624)
Total4: 2489173424 (1.248348)
Total5: 2497021163 (1.208170)


> And looking at the actual cmp functions used made me think we might do
> something similar to what you did for the swap functions for sort(),
> though it will require updating call sites.

Nifty idea, but A Separate Patch.

Here's a survey of which call sites would work:

! block/blk-mq.c:plug_rq_cmp(): ->mq_ctx, then ->mq_hctx, then blk_rq_pos()
- drivers/acpi/nfit/core.c:nfit_mem_cmp(): ->device_handle (u32)
! drivers/gpu/drm/drm_modes.c:drm_mode_compare(): ->type & DRM_MODE_TYPE_PREFERRED, then ->hdisplay * ->vdisplay, then ->vrefresh, then ->clock
- drivers/gpu/drm/i915/gvt/debugfs.c:mmio_offset_compare(): ->offset
- drivers/gpu/drm/i915/selftests/i915_gem_gtt.c:sort_holes(): ->start
- drivers/gpu/drm/radeon/radeon_cs.c:cmp_size_smaller_first(): ->tbo.num_pages
- drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c: interval_cmp(): ->start
- drivers/irqchip/irq-gic-v3-its.c:lpi_range_cmp(): ->base_id
- drivers/misc/sram.c:sram_reserve_cmp(): ->start
- drivers/nvme/host/core.c:ns_cmp(): ->ns_id
- drivers/spi/spi-loopback-test.c:rx_ranges_cmp(): ->start
- fs/btrfs/raid56.c:plug_cmp(): ->sector
- fs/btrfs/tree-log.c:extent_cmp(): ->start
- fs/btrfs/volumes.c:devid_cmp(): ->devid
- fs/ext4/fsmap.c:ext4_getfsmap_compare(): ->fmr_physical
- fs/gfs2/glock.c:glock_cmp(): ->gl_name.ln_number
- fs/gfs2/log.c:ip_cmp(): ->i_no_addr
- fs/gfs2/lops.c:blocknr_cmp(): ->b_blocknr
! fs/ubifs/gc.c:data_nodes_cmp(): key_inum(c, a), then key_block(c, a)
! fs/ubifs/gc.c:nondata_nodes_cmp(): ->type == UBIFS_INO_NODE, then lots of hair
- fs/ubifs/replay.c:replay_entries_cmp(): ->sqnum
! fs/xfs/xfs_trans_bmap.c:xfs_bmap_update_diff_items(): ->bi_owner->i_ino
! fs/xfs/xfs_trans_extfree.c:xfs_extent_free_diff_items(): XFS_FSB_TO_AGNO(mp, ra->xefi_startblock)
! fs/xfs/xfs_trans_refcount.c:xfs_refcount_update_diff_items(): XFS_FSB_TO_AGNO(mp, ra->ri_startblock)
! fs/xfs/xfs_trans_rmap.c:xfs_rmap_update_diff_items(): XFS_FSB_TO_AGNO(mp, ra->ri_bmap.br_startblock)
	(XFS_FSB_TO_AGNO is a right shift by mp->m_sb.sb_agblklog.
	Er... but why bother?  Is there any harm including the low-order
	bits in the comparison?  Is the shift just to ensure we don't
	overflow int?)
- fs/xfs/scrub/bitmap.c:xfs_bitmap_range_cmp(): ->start
- fs/xfs/xfs_buf.c:xfs_buf_cmp(): ->b_maps[0].bm_bn
- fs/xfs/xfs_extent_busy.c:xfs_extent_busy_ag_cmp(): ->agno
- lib/test_list_sort.c:cmp(): ->value
! virt/kvm/arm/vgic/vgic.c:vgic_irq_cmp(): raw_spin_lock(&irqa->irq_lock);

- means your idea would work
! means the compare is too complex

(It might be possible to adapt the xfs ones, though.)

> int do_cmp(void *priv, list_head *a, list_head *b, cmp_func cmp)
> {
>    if ((long)cmp & high_bits) /* it's a kernel pointer */
>       return cmp(priv, a, b);
>    int diff = extract_diff(cmp);
>    int type = extract_type(cmp);
[snip]
> in practice, we'd probably only have to support 4- and 8-byte signed and
> unsigned versions (and we can check at compile time whether key has a
> supported type).

There's no need to get so fancy with the encoding inside "cmp"; we
could just use cmp == NULL and encode it in "priv".  That avoids
depending on the kernel memory layout on various architectures.

> Similarly one could do a SORT_SIMPLE_CMP() for when sorting an array of
> structs according to a single numeric member. That sort is not stable,
> so the comparison functions would have to do a full -1,0,1 return, of
> course, but we'd still avoid indirect calls.

Actually, while some sorts (notably fat-pivot quicksort) require
a 3-way return to avoid O(n^2) performance, heapsort is just fine
with a boolean return value.  Since this would be an internal
implementation detail of sort(), we could use the optimization.

This doesn't have a priv pointer, however, so we'd have to go back
to the messy encoding.  But nobody sorts large structures by
copying, so the offsets are guaranteed small.  I'd say 12 bits
of offset would be fine, and the entire thing would be aliased to the
zero page.
