Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B935F206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMUsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:48:35 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:40497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:48:35 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKc0o-1iA0o20C4a-00Kyzz for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 21:48:34 +0100
Received: by mail-qk1-f174.google.com with SMTP id 71so3058489qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:48:33 -0800 (PST)
X-Gm-Message-State: APjAAAVnwXqkTUfvYKl2A2QGdT/mxRp1vj+bWx5SoCUMA5lYvrr3KXt0
        2p+LM6KhTOOd4cqU0CntakH5ukUaYCCqlK2Jgpw=
X-Google-Smtp-Source: APXvYqx7UkBV/kC0is9Dpo8dDdWGF+Zki5016/BoG73dW6kFhspK8vxYn64om37wWSVD3T/yekPlGM3LvP76mG8ZG74=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr890459qkb.138.1573678112912;
 Wed, 13 Nov 2019 12:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <s5hk1847rvm.wl-tiwai@suse.de>
 <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
 <s5hzhgzn304.wl-tiwai@suse.de> <CAK8P3a3n9hrb-qfAYW9=eYApSX=pkOK5p6iGe0T29-KqGuh0tg@mail.gmail.com>
 <s5hy2wjn1w2.wl-tiwai@suse.de> <CAK8P3a2+DgOBXS9MmPfvyyCUmqMB-pOx-qLjTV-VjDgStP6tww@mail.gmail.com>
 <s5h1rub7ih0.wl-tiwai@suse.de>
In-Reply-To: <s5h1rub7ih0.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 21:48:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0zNKyauCpZKoXuAeFmpJ-LAY8XhzwhxhMNAJsdbYdKAA@mail.gmail.com>
Message-ID: <CAK8P3a0zNKyauCpZKoXuAeFmpJ-LAY8XhzwhxhMNAJsdbYdKAA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Fix year 2038 issue for sound subsystem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RsmOEuqQRrcLGDI3e8ncqYwU1tV8Yd/hm85UT5acOEKyOM13Vi3
 oAzOScpu6h/B0xVhSbj+QW48881gmJe2irSyGREWC5tLGR3sIg7+C7WpOBcbPZCsUiqhPsO
 yrka+kuUrQSsVe+LFWmYXle5nz83EQ6bpRbXu8ncNV4u5C2YTbRn2lmJZ8BXTm9PEyuFu0M
 g98RS0pMdeu7bXz5O6DeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x3+RCMhxqKs=:VCQuXMuWnG+CSWtIiTOCRX
 FC/HX/wVvxPU8ccKm7g4NWt5k0R6scggkp2QDdGl94BldGxg1g17GlNYqms/jaWswowuJn0L/
 q8FmK0kM0SU6hzlm1vZoPsyUrjuZruHNtHwx/IaQNnA5FCTqWzJuZc8R29gfb0SiPeM89oAv2
 h6aFjRC0GmU8bKRkalBcBcfZLG56MjgLmTWdLUI8AwJZOcUyM8bYjTTbApiAURGCh74AlyL8n
 PmomOkPsMoIa7L9A8fcBIJFiWbhaACkx+CfFAlnpE2/4PJ+e474mQ5o57fxjqoJR1yq61kl2O
 I96lgujG8N3lE21NJxha20y0GH3rGJvD5Yxnze8ubnGUD97kpXhzpMgnqsxZfXiL+K1/jiFAR
 Ce+NqfK0HQmHayetx3nwRN3fFjhRhZips0Cw8bchcdtFix9Jzh6DHDU4Ym6nzNl1RcxxJeBrH
 BcrgJtBqMXm4+2dy6k4+7yN1YFXP9HjQ7a8oeWq8dSB3fHEgpSlAAVQPkWuOcc5DNskl/pujS
 yw/4NXd/5fmZU4mqKyC6pmV0kQ6EhL+0skjaEBbUTk8acyWOBl0oDSWHjidJFbnG508YfTkXB
 V+KjfN/fVAhn4pDHUx6oP+XEYU+nOJ0E1wC2RctabKeU1pvhPuP7FnlSHDP9bAZfNg9kG2AwE
 McMvPSC6McxoilapMy+2HCGvsdR9ifXo5kp/3bxsEMHsmVpPbYJytsMq0IgCjSknuDO0DbKLE
 b+Danyd64OGqazd7QLbypUSEjclRFLDpT7Fctp/ykMIZkJWkOYJ6CUIIRVkGFeu32BnFWptGq
 8TOi8J9mRt47N8CaV3tTltwvHnSqhnPh5Ui22O0dKwzD2GyCL4eMMx03wUBxEcsbPtNcx447k
 MXHxLeQjhmAoIDUoK5+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 7:13 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 13 Nov 2019 18:19:56 +0100, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2019 at 6:04 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > I don't mind much about that, so it's up to you -- we can fold this
> > > change into the patch that actually adds or modifies the ioctl, too.
> >
> > I've added the patch below to the end of the series now, will repost
> > the series  after no more comments come in for this version.
> > Having a single patch to update the version seems better than updating
> > it multiple times with each patch touching the ABI in this series.
>
> I wasn't clear enough.  Each ALSA device API has a protocol version,
> not only PCM, so we need updating SNDRV_RAWMIDI_VERSION and
> SNDRV_TIMER_VERSION as well.

Ok, I see. I've updated the patch to include all three, and adapted the
changelog text. There are still multiple changes for the PCM interface,
so this avoids having the version number change attached to half the
code changes.

     Arnd
