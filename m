Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20494206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfG2HDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:03:20 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56746 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfG2HDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:03:19 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hrzgh-0005SS-L6; Mon, 29 Jul 2019 09:03:15 +0200
Message-ID: <e96cf8a57c4633e807cfe82762397ad15ba19ed8.camel@sipsolutions.net>
Subject: Re: linux-next: build warning after merge of Linus' tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Jul 2019 09:03:14 +0200
In-Reply-To: <s5h8sshpbt3.wl-tiwai@suse.de>
References: <20190729140404.37bac29e@canb.auug.org.au>
         <s5h8sshpbt3.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 08:58 +0200, Takashi Iwai wrote:
> On Mon, 29 Jul 2019 06:04:04 +0200,
> Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the origin tree, today's linux-next build (powerpc
> > allyesconfig) produced this warning:
> > 
> > sound/aoa/codecs/onyx.c: In function 'onyx_snd_single_bit_get':
> > sound/aoa/codecs/onyx.c:377:37: warning: 'c' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   ucontrol->value.integer.value[0] = !!(c & mask) ^ polarity;
> >                                      ^~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> > 
> > This warning has been around for a long time.  It could possibly be
> > suppressed by checking for errors returned by onyx_read_register().
> 
> Yes, or simply zero-ing the variable in onyx_read_register().  The
> current code ignores the read error and it's been OK over a decade :)

Yeah, it's pretty weird that it never showed up before. I was wondering
for a minute why I was CC'ed on a sound merge issue :-)

Do you want me to send a patch or just commit something to suppress
this?

johannes

