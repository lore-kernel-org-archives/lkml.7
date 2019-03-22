Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47221900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCVAN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:13:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:30283 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfCVAN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:13:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 17:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309303572"
Received: from rdvivi-losangeles.jf.intel.com (HELO intel.com) ([10.7.196.65])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 17:13:26 -0700
Date:   Thu, 21 Mar 2019 17:13:41 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] linux-next: manual merge of the drm-intel tree with
 the drm-intel-fixes tree
Message-ID: <20190322001341.GK28473@intel.com>
References: <20190322105728.28622f5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322105728.28622f5d@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Mar 22, 2019 at 10:57:28AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-intel tree got a conflict in:
> 
>   drivers/gpu/drm/i915/gvt/mmio_context.c
> 
> between commit:
> 
>   1e8b15a1988e ("drm/i915/gvt: Add in context mmio 0x20D8 to gen9 mmio list")
> 
> from the drm-intel-fixes tree and commit:
> 
>   8a68d464366e ("drm/i915: Store the BIT(engine->id) as the engine's mask")
> 
> from the drm-intel tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I wonder how we could improve the situation here for drm-intel/drm-tip.
Because this wasn't a matter of not mentioning to upstream maintainer because
this was not sent up yet.

So I got this conflict after pulling gvt fixes to drm-intel-fixes
and conflict happened when reconstructing drm-intel. For us the
solution was easy because it was a matter of deciding for the -next
one.

And now it is recorded on our drm-rerere and nobody should face it again
here.

Maybe there is a way of reusing our drm-rerere somehow?

Please let me know if you have any ideas or suggestions.

Thanks,
Rodrigo.


> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/gpu/drm/i915/gvt/mmio_context.c
> index 7902fb162d09,a00a807a1d55..000000000000
> --- a/drivers/gpu/drm/i915/gvt/mmio_context.c
> +++ b/drivers/gpu/drm/i915/gvt/mmio_context.c
> @@@ -73,71 -73,70 +73,71 @@@ static struct engine_mmio gen8_engine_m
>   };
>   
>   static struct engine_mmio gen9_engine_mmio_list[] __cacheline_aligned = {
> - 	{RCS, GFX_MODE_GEN7, 0xffff, false}, /* 0x229c */
> - 	{RCS, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> - 	{RCS, HWSTAM, 0x0, false}, /* 0x2098 */
> - 	{RCS, INSTPM, 0xffff, true}, /* 0x20c0 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 0), 0, false}, /* 0x24d0 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 1), 0, false}, /* 0x24d4 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 2), 0, false}, /* 0x24d8 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 3), 0, false}, /* 0x24dc */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 4), 0, false}, /* 0x24e0 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 5), 0, false}, /* 0x24e4 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 6), 0, false}, /* 0x24e8 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 7), 0, false}, /* 0x24ec */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 8), 0, false}, /* 0x24f0 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 9), 0, false}, /* 0x24f4 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 10), 0, false}, /* 0x24f8 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 11), 0, false}, /* 0x24fc */
> - 	{RCS, CACHE_MODE_1, 0xffff, true}, /* 0x7004 */
> - 	{RCS, GEN7_GT_MODE, 0xffff, true}, /* 0x7008 */
> - 	{RCS, CACHE_MODE_0_GEN7, 0xffff, true}, /* 0x7000 */
> - 	{RCS, GEN7_COMMON_SLICE_CHICKEN1, 0xffff, true}, /* 0x7010 */
> - 	{RCS, HDC_CHICKEN0, 0xffff, true}, /* 0x7300 */
> - 	{RCS, VF_GUARDBAND, 0xffff, true}, /* 0x83a4 */
> - 
> - 	{RCS, GEN8_PRIVATE_PAT_LO, 0, false}, /* 0x40e0 */
> - 	{RCS, GEN8_PRIVATE_PAT_HI, 0, false}, /* 0x40e4 */
> - 	{RCS, GEN8_CS_CHICKEN1, 0xffff, true}, /* 0x2580 */
> - 	{RCS, COMMON_SLICE_CHICKEN2, 0xffff, true}, /* 0x7014 */
> - 	{RCS, GEN9_CS_DEBUG_MODE1, 0xffff, false}, /* 0x20ec */
> - 	{RCS, GEN8_L3SQCREG4, 0, false}, /* 0xb118 */
> - 	{RCS, GEN7_HALF_SLICE_CHICKEN1, 0xffff, true}, /* 0xe100 */
> - 	{RCS, HALF_SLICE_CHICKEN2, 0xffff, true}, /* 0xe180 */
> - 	{RCS, HALF_SLICE_CHICKEN3, 0xffff, true}, /* 0xe184 */
> - 	{RCS, GEN9_HALF_SLICE_CHICKEN5, 0xffff, true}, /* 0xe188 */
> - 	{RCS, GEN9_HALF_SLICE_CHICKEN7, 0xffff, true}, /* 0xe194 */
> - 	{RCS, GEN8_ROW_CHICKEN, 0xffff, true}, /* 0xe4f0 */
> - 	{RCS, TRVATTL3PTRDW(0), 0, false}, /* 0x4de0 */
> - 	{RCS, TRVATTL3PTRDW(1), 0, false}, /* 0x4de4 */
> - 	{RCS, TRNULLDETCT, 0, false}, /* 0x4de8 */
> - 	{RCS, TRINVTILEDETCT, 0, false}, /* 0x4dec */
> - 	{RCS, TRVADR, 0, false}, /* 0x4df0 */
> - 	{RCS, TRTTE, 0, false}, /* 0x4df4 */
> - 
> - 	{BCS, RING_GFX_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2229c */
> - 	{BCS, RING_MI_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2209c */
> - 	{BCS, RING_INSTPM(BLT_RING_BASE), 0xffff, false}, /* 0x220c0 */
> - 	{BCS, RING_HWSTAM(BLT_RING_BASE), 0x0, false}, /* 0x22098 */
> - 	{BCS, RING_EXCC(BLT_RING_BASE), 0x0, false}, /* 0x22028 */
> - 
> - 	{VCS2, RING_EXCC(GEN8_BSD2_RING_BASE), 0xffff, false}, /* 0x1c028 */
> - 
> - 	{VECS, RING_EXCC(VEBOX_RING_BASE), 0xffff, false}, /* 0x1a028 */
> - 
> - 	{RCS, GEN8_HDC_CHICKEN1, 0xffff, true}, /* 0x7304 */
> - 	{RCS, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> - 	{RCS, GEN7_UCGCTL4, 0x0, false}, /* 0x940c */
> - 	{RCS, GAMT_CHKN_BIT_REG, 0x0, false}, /* 0x4ab8 */
> - 
> - 	{RCS, GEN9_GAMT_ECO_REG_RW_IA, 0x0, false}, /* 0x4ab0 */
> - 	{RCS, GEN9_CSFE_CHICKEN1_RCS, 0xffff, false}, /* 0x20d4 */
> - 	{RCS, _MMIO(0x20D8), 0xffff, true}, /* 0x20d8 */
> - 
> - 	{RCS, GEN8_GARBCNTL, 0x0, false}, /* 0xb004 */
> - 	{RCS, GEN7_FF_THREAD_MODE, 0x0, false}, /* 0x20a0 */
> - 	{RCS, FF_SLICE_CS_CHICKEN2, 0xffff, false}, /* 0x20e4 */
> - 	{RCS, INVALID_MMIO_REG, 0, false } /* Terminated */
> + 	{RCS0, GFX_MODE_GEN7, 0xffff, false}, /* 0x229c */
> + 	{RCS0, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> + 	{RCS0, HWSTAM, 0x0, false}, /* 0x2098 */
> + 	{RCS0, INSTPM, 0xffff, true}, /* 0x20c0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 0), 0, false}, /* 0x24d0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 1), 0, false}, /* 0x24d4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 2), 0, false}, /* 0x24d8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 3), 0, false}, /* 0x24dc */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 4), 0, false}, /* 0x24e0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 5), 0, false}, /* 0x24e4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 6), 0, false}, /* 0x24e8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 7), 0, false}, /* 0x24ec */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 8), 0, false}, /* 0x24f0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 9), 0, false}, /* 0x24f4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 10), 0, false}, /* 0x24f8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 11), 0, false}, /* 0x24fc */
> + 	{RCS0, CACHE_MODE_1, 0xffff, true}, /* 0x7004 */
> + 	{RCS0, GEN7_GT_MODE, 0xffff, true}, /* 0x7008 */
> + 	{RCS0, CACHE_MODE_0_GEN7, 0xffff, true}, /* 0x7000 */
> + 	{RCS0, GEN7_COMMON_SLICE_CHICKEN1, 0xffff, true}, /* 0x7010 */
> + 	{RCS0, HDC_CHICKEN0, 0xffff, true}, /* 0x7300 */
> + 	{RCS0, VF_GUARDBAND, 0xffff, true}, /* 0x83a4 */
> + 
> + 	{RCS0, GEN8_PRIVATE_PAT_LO, 0, false}, /* 0x40e0 */
> + 	{RCS0, GEN8_PRIVATE_PAT_HI, 0, false}, /* 0x40e4 */
> + 	{RCS0, GEN8_CS_CHICKEN1, 0xffff, true}, /* 0x2580 */
> + 	{RCS0, COMMON_SLICE_CHICKEN2, 0xffff, true}, /* 0x7014 */
> + 	{RCS0, GEN9_CS_DEBUG_MODE1, 0xffff, false}, /* 0x20ec */
> + 	{RCS0, GEN8_L3SQCREG4, 0, false}, /* 0xb118 */
> + 	{RCS0, GEN7_HALF_SLICE_CHICKEN1, 0xffff, true}, /* 0xe100 */
> + 	{RCS0, HALF_SLICE_CHICKEN2, 0xffff, true}, /* 0xe180 */
> + 	{RCS0, HALF_SLICE_CHICKEN3, 0xffff, true}, /* 0xe184 */
> + 	{RCS0, GEN9_HALF_SLICE_CHICKEN5, 0xffff, true}, /* 0xe188 */
> + 	{RCS0, GEN9_HALF_SLICE_CHICKEN7, 0xffff, true}, /* 0xe194 */
> + 	{RCS0, GEN8_ROW_CHICKEN, 0xffff, true}, /* 0xe4f0 */
> + 	{RCS0, TRVATTL3PTRDW(0), 0, false}, /* 0x4de0 */
> + 	{RCS0, TRVATTL3PTRDW(1), 0, false}, /* 0x4de4 */
> + 	{RCS0, TRNULLDETCT, 0, false}, /* 0x4de8 */
> + 	{RCS0, TRINVTILEDETCT, 0, false}, /* 0x4dec */
> + 	{RCS0, TRVADR, 0, false}, /* 0x4df0 */
> + 	{RCS0, TRTTE, 0, false}, /* 0x4df4 */
> + 
> + 	{BCS0, RING_GFX_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2229c */
> + 	{BCS0, RING_MI_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2209c */
> + 	{BCS0, RING_INSTPM(BLT_RING_BASE), 0xffff, false}, /* 0x220c0 */
> + 	{BCS0, RING_HWSTAM(BLT_RING_BASE), 0x0, false}, /* 0x22098 */
> + 	{BCS0, RING_EXCC(BLT_RING_BASE), 0x0, false}, /* 0x22028 */
> + 
> + 	{VCS1, RING_EXCC(GEN8_BSD2_RING_BASE), 0xffff, false}, /* 0x1c028 */
> + 
> + 	{VECS0, RING_EXCC(VEBOX_RING_BASE), 0xffff, false}, /* 0x1a028 */
> + 
> + 	{RCS0, GEN8_HDC_CHICKEN1, 0xffff, true}, /* 0x7304 */
> + 	{RCS0, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> + 	{RCS0, GEN7_UCGCTL4, 0x0, false}, /* 0x940c */
> + 	{RCS0, GAMT_CHKN_BIT_REG, 0x0, false}, /* 0x4ab8 */
> + 
> + 	{RCS0, GEN9_GAMT_ECO_REG_RW_IA, 0x0, false}, /* 0x4ab0 */
> + 	{RCS0, GEN9_CSFE_CHICKEN1_RCS, 0xffff, false}, /* 0x20d4 */
> ++	{RCS0, _MMIO(0x20D8), 0xffff, true}, /* 0x20d8 */
> + 
> + 	{RCS0, GEN8_GARBCNTL, 0x0, false}, /* 0xb004 */
> + 	{RCS0, GEN7_FF_THREAD_MODE, 0x0, false}, /* 0x20a0 */
> + 	{RCS0, FF_SLICE_CS_CHICKEN2, 0xffff, false}, /* 0x20e4 */
> + 	{RCS0, INVALID_MMIO_REG, 0, false } /* Terminated */
>   };
>   
>   static struct {



> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

