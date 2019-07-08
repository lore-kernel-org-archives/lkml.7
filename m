Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5353C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997920665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiH0fUpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfGHDu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:50:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43352 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfGHDu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:50:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so6891264pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9vVYlV8jHaOi3h5bnfqso7qoB4Bj+SDzA7uVn9y1Zg=;
        b=FiH0fUpUBSgADmxo/DXQxUYeqdxGYa5VG8WYJK8sUnFukrC1LqSNwtKUR8iwrRz07J
         gOaUnuaRm5zM4wl+BRg9gjhQgmHY/RpbC/d6T6H/8Fzkwlyv6xSBkP5qwhjh2O0GOFdq
         HJOTUMswLofH+qXanorGfgi5g3WlUrCFP9V/MHFRzRAkz6ZdDbm27o9IL9ZlYILRf6mk
         tMNMCN5vJPE65s5Ec1ZYhcEpTVNwulDHcEysy/SJOU/yjK++Z5uX0ZGdyauI1vL6xw/K
         iET/LXy969IBCYAtbihwZvR6wvZeSfNBglN1czic7w4KImdVO50hMxYVVvvPOWso53X/
         0lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9vVYlV8jHaOi3h5bnfqso7qoB4Bj+SDzA7uVn9y1Zg=;
        b=D5A/qqSGqxGOx00ZA5do1o2n0IiEqcBp8CHTQ9TvEs7THmPmp8m6Nj07Or+tZDoeid
         DgoOy6oxAjEBK8Uw8Dy5vFvmCq2wxm4F5RUC2M/LKcWmBc3NwAgk/OR1e+e+x00ZDfMl
         Oj9FEENF+0Iv2Eqly5vwowt/d3dI0uAsjfz4PewA8y2tr381chWohMhI/q6/eTDKJRNI
         +Q4m/rGBIhGM5hedJTZvpZ1PMiGON4YwgKdcZsZ98wDEUYeeGvJS1eYF4V3oUtHatVnY
         c5RHd1C0p5lC2ORpHER4u8MzPBhaWm0T+tl0PapI/q2gwaGsvOsJXK5St+Be2GXYnWi8
         3WwA==
X-Gm-Message-State: APjAAAXv/Zz73I/ui2B4knZS2UVtw36ilhPAUM4XWJ3j3Rc9gjeYuI2W
        XOqRI5Z+lH/AZ5UD2xEBMoc=
X-Google-Smtp-Source: APXvYqxWJyLLgR7Xtjos8z8DRQCG0tRkM0SrLRMTxYSqNjbi7Li8R/3WEizUu8uJQvDY42Jo7CD3Gg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr22396401pjr.8.1562557858270;
        Sun, 07 Jul 2019 20:50:58 -0700 (PDT)
Received: from Slackware ([103.231.90.173])
        by smtp.gmail.com with ESMTPSA id i126sm16116782pfb.32.2019.07.07.20.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 20:50:57 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:20:46 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.2
Message-ID: <20190708035046.GA18628@Slackware>
References: <CAHk-=whtW3FdruS-q2zehJPSan1SKtHoFHKX28A3J_1gfTFUMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAHk-=whtW3FdruS-q2zehJPSan1SKtHoFHKX28A3J_1gfTFUMw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Well, thanks a bunch Linus :)

On 16:10 Sun 07 Jul , Linus Torvalds wrote:
>So I was somewhat pre-disposed towards making an rc8, simply because
>of my travels and being entirely off the internet for a few days last
>week, and with spotty internet for a few days before that [*].
>
>But there really doesn't seem to be any reason for another rc, since
>it's been very quiet. Yes, I had a few pull requests since rc7, but
>they were all small, and I had many more that are for the upcoming
>merge window. Part of it may be due to the July 4th week, of course,
>but whatever - I'll take the quiet week as a good sign.
>
>So despite a fairly late core revert, I don't see any real reason for
>another week of rc, and so we have a v5.2 with the normal release
>timing.
>
>There's no particular area that stands out there - the changes are so
>small that the sppended shortlog really is the best description of
>last week. A few small random changes all over: drivers,
>architectures, filesystem, mm, ...
>
>So with this, the merge window for 5.2 is open.
>
>           Linus
>
>[*] Courtesy of the Ocean Hunter III in Palau.
>
>Because of blurry fish-butt, I don't carry a camera under water any
>more, but I guess can point you to some of Dirk's highlights:
>
>   https://hohndel.name/palau-2019
>
>---
>
>Alex Deucher (1):
>      drm/amdgpu/gfx9: use reset default for PA_SC_FIFO_SIZE
>
>Ard Biesheuvel (1):
>      arm64: kaslr: keep modules inside module region when KASAN is enabled
>
>Arnd Bergmann (2):
>      soc: ti: fix irq-ti-sci link error
>      devres: allow const resource arguments
>
>Bartosz Golaszewski (3):
>      ARM: davinci: da830-evm: add missing regulator constraints for OHCI
>      ARM: davinci: omapl138-hawk: add missing regulator constraints for OHCI
>      ARM: davinci: da830-evm: fix GPIO lookup for OHCI
>
>Boris Brezillon (1):
>      drm/panfrost: Fix a double-free error
>
>Cedric Hombourger (1):
>      MIPS: have "plain" make calls build dtbs for selected platforms
>
>Chris Wilson (1):
>      drm/i915/ringbuffer: EMIT_INVALIDATE *before* switch context
>
>Christian Brauner (1):
>      fork: return proper negative error code
>
>Chuck Lever (1):
>      svcrdma: Ignore source port when computing DRC hash
>
>Colin Ian King (2):
>      ALSA: usb-audio: fix sign unintended sign extension on left shifts
>      ALSA: seq: fix incorrect order of dest_client/dest_ports arguments
>
>Dan Carpenter (1):
>      dmaengine: jz4780: Fix an endian bug in IRQ handler
>
>Dennis Wassenberg (1):
>      ALSA: hda/realtek - Change front mic location for Lenovo M710q
>
>Dmitry Korotin (1):
>      MIPS: Add missing EHB in mtc0 -> mfc0 sequence.
>
>Dmitry Osipenko (1):
>      i2c: tegra: Add Dmitry as a reviewer
>
>Eiichi Tsukata (1):
>      tracing/snapshot: Resize spare buffer if size changed
>
>Eric Biggers (3):
>      vfs: move_mount: reject moving kernel internal mounts
>      crypto: user - prevent operating on larval algorithms
>      fs/userfaultfd.c: disable irqs for fault_pending and event locks
>
>Evan Green (1):
>      ALSA: hda: Fix widget_mutex incomplete protection
>
>Evan Quan (1):
>      drm/amd/powerplay: use hardware fan control if no powerplay fan table
>
>Frieder Schrempf (1):
>      mtd: spinand: Fix max_bad_eraseblocks_per_lun info in memorg
>
>Geert Uytterhoeven (1):
>      fs: VALIDATE_FS_PARSER should default to n
>
>Gerd Hoffmann (1):
>      drm/virtio: move drm_connector_update_edid_property() call
>
>Greg Kroah-Hartman (1):
>      blk-mq: fix up placement of debugfs directory of queue files
>
>Hauke Mehrtens (1):
>      MIPS: Fix bounds check virt_addr_valid
>
>Herbert Xu (1):
>      lib/mpi: Fix karactx leak in mpi_powm
>
>Jan Kara (1):
>      dax: Fix xarray entry association for mixed mappings
>
>Jann Horn (1):
>      ptrace: Fix ->ptracer_cred handling for PTRACE_TRACEME
>
>Jiri Kosina (1):
>      ftrace/x86: Anotate text_mutex split between
>ftrace_arch_code_modify_post_process() and
>ftrace_arch_code_modify_prepare()
>
>Joshua Scott (1):
>      ARM: dts: armada-xp-98dx3236: Switch to armada-38x-uart serial node
>
>Juergen Gross (1):
>      mm/page_alloc.c: fix regression with deferred struct page init
>
>Kevin Darbyshire-Bryant (1):
>      MIPS: fix build on non-linux hosts
>
>Linus Torvalds (2):
>      Revert "mm: page cache: store only head pages in i_pages"
>      Linux 5.2
>
>Linus Walleij (1):
>      gpio/spi: Fix spi-gpio regression on active high CS
>
>Liran Alon (2):
>      KVM: nVMX: Allow restore nested-state to enable eVMCS when vCPU in SMM
>      KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is
>copied from eVMCS
>
>Lucas Stach (1):
>      drm/etnaviv: add missing failure path to destroy suballoc
>
>Lyude Paul (1):
>      drm/amdgpu: Don't skip display settings in hwmgr_resume()
>
>Matias Karhumaa (1):
>      Bluetooth: Fix faulty expression for minimum encryption key size check
>
>Maurizio Lombardi (1):
>      scsi: iscsi: set auth_protocol back to NULL if CHAP_A value is
>not supported
>
>Miquel Raynal (2):
>      Revert "mtd: rawnand: sunxi: Add A23/A33 DMA support"
>      mtd: rawnand: sunxi: Add A23/A33 DMA support with extra MBUS configuration
>
>Nathan Chancellor (1):
>      arm64/efi: Mark __efistub_stext_offset as an absolute symbol explicitly
>
>Oleg Nesterov (1):
>      swap_readpage(): avoid blk_wake_io_task() if !synchronous
>
>Paolo Bonzini (1):
>      KVM: x86: degrade WARN to pr_warn_ratelimited
>
>Paul Cercueil (2):
>      MAINTAINERS: Correct path to moved files
>      mtd: rawnand: ingenic: Fix ingenic_ecc dependency
>
>Paul Menzel (1):
>      nfsd: Fix overflow causing non-working mounts on 1 TB machines
>
>Petr Mladek (1):
>      ftrace/x86: Remove possible deadlock between register_kprobe()
>and ftrace_run_update_code()
>
>Richard Sailer (1):
>      ALSA: hda/realtek: Add quirks for several Clevo notebook barebones
>
>Robert Beckett (2):
>      drm/imx: notify drm core before sending event during crtc disable
>      drm/imx: only send event on crtc disable if kept disabled
>
>Robin Gong (1):
>      dmaengine: imx-sdma: remove BD_INTR for channel0
>
>Roman Bolshakov (1):
>      scsi: target/iblock: Fix overrun in WRITE SAME emulation
>
>Ronnie Sahlberg (1):
>      cifs: fix crash querying symlinks stored as reparse-points
>
>Shakeel Butt (1):
>      mm/vmscan.c: prevent useless kswapd loops
>
>Sricharan R (1):
>      dmaengine: qcom: bam_dma: Fix completed descriptors count
>
>Stefan Hellermann (1):
>      MIPS: ath79: fix ar933x uart parity mode
>
>Steven Rostedt (VMware) (1):
>      ftrace/x86: Add a comment to why we take text_mutex in
>ftrace_arch_code_modify_prepare()
>
>Sven Van Asbroeck (1):
>      dmaengine: imx-sdma: fix use-after-free on probe error path
>
>Takashi Iwai (1):
>      ALSA: line6: Fix write on zero-sized buffer
>
>Takashi Sakamoto (1):
>      ALSA: firewire-lib/fireworks: fix miss detection of received MIDI messages
>
>Takeshi Misawa (1):
>      tracing: Fix memory leak in tracing_err_log_open()
>
>Vincent Whitchurch (1):
>      crypto: cryptd - Fix skcipher instance memory leak
>
>Wanpeng Li (1):
>      KVM: LAPIC: Fix pending interrupt in IRR blocked by software disable LAPIC
>
>Zhang Lei (1):
>      KVM: arm64/sve: Fix vq_present() macro to yield a bool

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl0ivZAACgkQsjqdtxFL
KRWZqAf/Y01kRh427RNZW1IKD15s6Sot9JwFTDpP6pIYifUZPrhUWoHVezn1TGfX
UUZ0QZRqFVsqiSdL4Vb8XdyOktoVijsjaVfvdaQlB4pYQIbGHfyEAWGp8YKhKbgW
wieceQhv/VS6r/uCnKKFuYYpJuLMrUDMFg1HIlwpx3VLng7k6SR3YORrhzBRF2wC
VVPQUQvFBRCr5hW68Q+CXzYa8x1W3SjthJn3TmsgABvQkzesgKfZavdEuIOrQTtA
v6ew3+x7Xb5eL+ldPq+JQdRAVOkblV3rsQTjWuVWsYCfugTn3IXK0iQNBhuyl6Qv
O6Jt9hBX+G3L+qPWO7YOVtQLpSVSUg==
=oNiV
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
