Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE14C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1D820673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgAHKb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:31:26 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:40343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAHKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:31:25 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N63NW-1jmRKF0pwW-016MwO for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 11:31:23 +0100
Received: by mail-qk1-f169.google.com with SMTP id w127so2102058qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:31:22 -0800 (PST)
X-Gm-Message-State: APjAAAVZvAyZXmIooq0zHL4BcCmen79dwCorVwbQ9Z9gsIlC/zvMtRjW
        IflaFd2XNINY1UgArGX9gecBY45x9qwJ67JlGg4=
X-Google-Smtp-Source: APXvYqyhlwawSyTf5aVJ0Eab5k8mO35w/P4gl0bOQkiomDlqk+RzlP137GT/eokTJwASNeOCqWrTC0WxbzatGEhiYf8=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr3552221qke.394.1578479482002;
 Wed, 08 Jan 2020 02:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20200107212747.4182515-1-arnd@arndb.de> <20200107220019.GC7869@pendragon.ideasonboard.com>
 <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com>
 <20200107221222.GE7869@pendragon.ideasonboard.com> <CAK8P3a0ny0UhOpvVNE3x6gE=3SG7h_sBvtR7L7Hj2XsjrkavAA@mail.gmail.com>
In-Reply-To: <CAK8P3a0ny0UhOpvVNE3x6gE=3SG7h_sBvtR7L7Hj2XsjrkavAA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 11:31:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3jAnFZA3GFRtdYdg1-i-oih3pOQzkkrK-X3BGsFrMiZQ@mail.gmail.com>
Message-ID: <CAK8P3a3jAnFZA3GFRtdYdg1-i-oih3pOQzkkrK-X3BGsFrMiZQ@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: fix excessive stack usage in td028ttec1_prepare
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GtSMX4d6Pz5+tPvODnEJzQvB/bhyjAvBIfauWzsYIVJcj5rA3VV
 YgaUAoun6UVgLndki4qxnDEglABz1M1fe0PLxqKXriQCL87uDX9IKb4/t/8b9FRWBcv6iKt
 K3n3GT3ng11csmax7QEGId9oQigxEQ90MFLER2+VDdXc9r5b8awHKY3Vw0URfFEljIQwEm5
 zdVrZhTalLTw4pCSYQO+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pcrRbgLk2R4=:UzMIkbY37PcIjyr9XH0v1S
 UU7wE7/ER2kiZpkZ5Y0MRsYa0+5gD/VC4RzzCqRYTpw8hjHj4Hda1r9JpgLk5r746lb0LvbZN
 fP94xZF82W2gOhpUGLU8YM+++O8OcH/RZ8hQ3JU20CjZuleQGgDf/7zAoz7DJrVTIrp8nD7Jd
 jK6CFqIOSzn9oNAgsanbrjJl4QeE9vv8p4rx8vWgchf6qCW3e2kFYdmkUSkBRoh7tUc4gExgo
 O4w/g5kFJPEHCidI2wenlnsAmVGH1jPiq2k/R2dGzDmBToWpfw3FHQJpkBnV3nm4vGTGt7kDn
 JkwD5cik4xVNJR81ZDBuHWMSTR7YrXv+m7aWA32bfpo7w56r/XnjSZB9qnuvTp08knCgX6Kst
 6XTTYGRnUFmwgke+2LvaQKghAPywQJjGgSFmS7RSBVHMDIV/UfdBMMJGfl+uaS0Pbp6SKxU/K
 4pokgr0ouiWSbvuWdFyO2cX33q6MReVfODcJ+xLP+mmVPTGI5+84RkeILsyBfj+TDhmlUIr6Z
 u+5W+FXEtLYu33/7yrcOaRTrjwJKyaAUGMRsb0TVnPunnVx6hoauAxOhySRuuNLDO9lCLadtD
 d/RdWEltuRx0VPXSW5b3zcWQCxoYtUSjLhZARrBFGieQdewsnMJrBDppCcynXM1kuZc2bwtQf
 ZDfl4Q7qLNYZX+HNIk00fDScVBnt2lZST8GOv31mXxGr0ZwdedUFyvaLzWQd2mxd645cjjWmT
 wdlmRvkV4G2uzki32x+K1xrU+Qq+FhkcF9P3OCjn259+57DDm5CPZ6dTBy3y996mLbRQPdzv6
 n9EQ26mV8QBpVgLhmGSP1YE5sCVgxnhI9g7A1f+KyKlZvnSYA+N55ek75AO0eTZ8BlWn/bz/s
 2y8WafEgSnv2emJ28xKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 7, 2020 at 11:12 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Tue, Jan 07, 2020 at 11:09:13PM +0100, Arnd Bergmann wrote:
> > > On Tue, Jan 7, 2020 at 11:00 PM Laurent Pinchart wrote:
>
> > > > Isn't this something that should be fixed at the compiler level ?
> > >
> > > I suspect but have not verified that structleak gcc plugin is partly at
> > > fault here as well, it has caused similar problems elsewhere.
>
> I checked that now, and it's indeed the structleak plugin.
>
> Interestingly the problem goes away without the -fconserve-stack
> option, which is meant to reduce the stack usage bug has the
> opposite effect here (!).
>
> I'll do some more tests tomorrow.

Here's a reduced test case:

struct list_head {
  struct list_head *next, *prev;
} typedef initcall_t;
struct sg_table {
  int sgl;
  int nents;
  int orig_nents;
};
struct spi_transfer {
  void *tx_buf;
  void *rx_buf;
  unsigned len;
  int tx_dma;
  int rx_dma;
  struct sg_table tx_sg;
  struct sg_table rx_sg;
  short delay_usecs;
  int delay;
  int cs_change_delay;
  int word_delay;
  int speed_hz;
  int effective_speed_hz;
  int ptp_sts_word_pre;
  int ptp_sts_word_post;
  int ptp_sts;
  _Bool timestamped_pre;
  struct list_head transfer_list;
};
void spi_sync_transfer(struct spi_transfer *, int);
void spi_write(void) {
  struct spi_transfer t;
  spi_sync_transfer(&t, 0);
}
int jbt_ret_write_0_err;
void jbt_ret_write_0(void) {
  if (jbt_ret_write_0_err)
    spi_write();
}
void jbt_reg_write_1(int *err) {
  if (*err) {
    struct spi_transfer t;
    spi_sync_transfer(&t, 1);
  }
}
void jbt_reg_write_2(int *err) {
  short tx_buf[3];
  if (err) {
    struct spi_transfer t = {tx_buf};
    spi_sync_transfer(&t, 0);
  }
}
int td028ttec1_prepare_i;
void td028ttec1_prepare() {
  int ret;
  for (; td028ttec1_prepare_i; ++td028ttec1_prepare_i) {
    jbt_ret_write_0();
  }
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_2(&ret);
  jbt_ret_write_0();
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
  jbt_reg_write_1(&ret);
}

$ arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc panel-tpo-td028ttec1.c
-fplugin=scripts/gcc-plugins/structleak_plugin.so
-fplugin-arg-structleak_plugin-byref-all  -S -O3
-Wframe-larger-than=128
panel-tpo-td028ttec1.i: In function 'td028ttec1_prepare':
panel-tpo-td028ttec1.i:80:1: warning: the frame size of 192 bytes is
larger than 128 bytes [-Wframe-larger-than=]

$ arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc panel-tpo-td028ttec1.c
-fplugin=scripts/gcc-plugins/structleak_plugin.so
-fplugin-arg-structleak_plugin-byref-all  -S -O3
-Wframe-larger-than=128 -fconserve-stack
panel-tpo-td028ttec1.i: In function 'td028ttec1_prepare':
panel-tpo-td028ttec1.i:80:1: warning: the frame size of 2032 bytes is
larger than 128 bytes [-Wframe-larger-than=]

I'm still not entirely sure what to make of this. The -fconserve-stack
is supposed
to prevent inlining when the frames get too large, but it appears that inlining
less has the opposite effect here, as it leaves larger structures on the stack
of the caller. structleak_plugin-byref-all causes each copy of the
'struct spi_transfer'
to be initialized (intentionally) and left on the stack (as a
side-effect of a somewhat
suboptimal implementation).

         Arnd
