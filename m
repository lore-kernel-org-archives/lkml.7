Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BDCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096521835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572273629;
	bh=dmNS+or+xqTf7DWc23tqF8ino6TFJyoztCnlmTog0ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bo44LhJyU7zj7MurNxdsBtfoNIGExA+XEMAan1E2M+kWHzdEhi8GoKirtjy6Exd3d
	 2ZWgRl+3iBQMP4n6MMduP6fOsWLBapxircpxLcBPAj2C+xvPFsJxG05QMu1uIEfu2q
	 n6tZmr6psaI27uQoHLrYdu8KvjRo+QOPKqYQiJWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfJ1Ok2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbfJ1Ok1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:40:27 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EFC21721;
        Mon, 28 Oct 2019 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572273627;
        bh=dmNS+or+xqTf7DWc23tqF8ino6TFJyoztCnlmTog0ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9R1oKirOJsZSdHSDJ75V+onIuAjbZ8FC4w9OUTpOjJSdOG4HkaXhCSG0fyBc7tsL
         8SoAd6V/tmB0sb3JpogsUSsxakuGaFtjrrkbpIZ7iQaIrL5ZaYr2vCWd7qYfe7UkMa
         6227OncaKO6YJYgplKfSHvj3J4uuRTDpVP1BCOv8=
Date:   Mon, 28 Oct 2019 15:40:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+8f2612936028bfd28f28@syzkaller.appspotmail.com>,
        allison@lohutok.net, alsa-devel@alsa-project.org,
        benquike@gmail.com, dan.carpenter@oracle.com, glider@google.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, wang6495@umn.edu, yuehaibing@huawei.com
Subject: Re: KMSAN: uninit-value in get_term_name
Message-ID: <20191028144024.GA120200@kroah.com>
References: <000000000000f838060595f602a7@google.com>
 <s5hr22xau8f.wl-tiwai@suse.de>
 <20191028133050.GA13691@kroah.com>
 <s5himo9as9j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5himo9as9j.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:55:52PM +0100, Takashi Iwai wrote:
> On Mon, 28 Oct 2019 14:30:50 +0100,
> Greg KH wrote:
> > 
> > On Mon, Oct 28, 2019 at 02:13:20PM +0100, Takashi Iwai wrote:
> > > On Mon, 28 Oct 2019 11:32:07 +0100,
> > > syzbot wrote:
> > > > 
> > > > Uninit was stored to memory at:
> > > >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
> > > >  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
> > > >  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
> > > >  parse_term_proc_unit+0x73d/0x7e0 sound/usb/mixer.c:896
> > > >  __check_input_term+0x13ef/0x2360 sound/usb/mixer.c:989
> > > 
> > > So this comes from the invalid descriptor for a processing unit, and
> > > it's very likely the same issue as already spotted -- the validator up
> > > to 5.3-rc4 had a bug that passed the invalid descriptor falsely.
> > > This should have been covered by 5.3-rc5, commit ba8bf0967a15 ("ALSA:
> > > usb-audio: Fix copy&paste error in the validator").
> > 
> > SHould we be backporting the validator to any older kernels as well?
> 
> Yes, that would be nice.  I didn't mark them for stable just because
> they are a bit largish and wanted to let them tested for 5.4 for a
> while.
> 
> The following commits are relevant (from top/old to bottom/new).
> 
> 57f8770620e9b51c61089751f0b5ad3dbe376ff2
>     ALSA: usb-audio: More validations of descriptor units
> 68e9fde245591d18200f8a9054cac22339437adb
>     ALSA: usb-audio: Simplify parse_audio_unit()
> 52c3e317a857091fd746e15179a637f32be4d337
>     ALSA: usb-audio: Unify the release of usb_mixer_elem_info objects
> b8e4f1fdfa422398c2d6c47bfb7d1feb3046d70a
>     ALSA: usb-audio: Remove superfluous bLength checks
> e0ccdef92653f8867e2d1667facfd3c23699f540
>     ALSA: usb-audio: Clean up check_input_term()
> 60849562a5db4a1eee2160167e4dce4590d3eafe
>     ALSA: usb-audio: Fix possible NULL dereference at create_yamaha_midi_quirk()
> b39e077fcb283dd96dd251a3abeba585402c61fe
>     ALSA: usb-audio: remove some dead code
> ba8bf0967a154796be15c4983603aad0b05c3138
>     ALSA: usb-audio: Fix copy&paste error in the validator
> 

Thanks, I'll look at these for the next round of kernels.

greg k-h
