Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D42C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2B21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VCxaaTIt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iGO0vzMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfGLOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:19:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57290 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbfGLOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:19:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 19D7A8EE331;
        Fri, 12 Jul 2019 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562941188;
        bh=Dp5a0UrH9hKoPaQtN8NMeqGJ73pmNknix42kASn6zxs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VCxaaTItFh6NC+DFhY5jQFgBXHoCm+NCJSqectbFZbBep25ieqYrtlTfwSiZZZZBB
         8BsXsUeOPXxuxXysoVjlBzluStZeuXYBzSh9KT1JmROTOLAn4yYEKmvg7th5/2W1oP
         cm6iDhW90Dn+SrZldgLwk55/D4sSC1p9HSNS/nPc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0Jw-QcXrd_p4; Fri, 12 Jul 2019 07:19:47 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6925F8EE1F7;
        Fri, 12 Jul 2019 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562941187;
        bh=Dp5a0UrH9hKoPaQtN8NMeqGJ73pmNknix42kASn6zxs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iGO0vzMtpj+2FTqUdMvhfBOs8fjXi7+T29UOioFgPCgGq5ucBAQEuaKfZDSAh0SNm
         0zTJwZZmCWp/3z+Vi1Sci9qtPHTrwPjf/H+zgAyMmmAmKoB9nZJIFVv9cOJC/vKhj8
         DDAHJ3E3j7M8wT1RSFNRT2gMRXtfcXCXy68x54yg=
Message-ID: <1562941185.3398.1.camel@HansenPartnership.com>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jul 2019 07:19:45 -0700
In-Reply-To: <1562888433.2915.0.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
         <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
         <55f4d1c242d684ca2742e8c14613d810a9ee9504.camel@intel.com>
         <1562888433.2915.0.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 16:40 -0700, James Bottomley wrote:
> On Thu, 2019-07-11 at 23:28 +0000, Souza, Jose wrote:
> > On Fri, 2019-07-12 at 01:03 +0200, Paul Bolle wrote:
> > > James Bottomley schreef op do 11-07-2019 om 15:38 [-0700]:
> > > > On Thu, 2019-07-11 at 22:26 +0000, Souza, Jose wrote:
> > > > > It eventually comes back from screen freeze? Like moving the
> > > > > mouse or typing brings it back?
> > > > 
> > > > No, it seems to be frozen for all time (at least until I got
> > > > bored waiting, which was probably 20 minutes).  Even if I
> > > > reboot the machine, the current screen state stays until the
> > > > system powers off.
> > > 
> > > As I mentioned earlier, a suspend/resume cycle unfreezes the
> > > screen.
> > > 
> > > And I seem to remember that, if the gnome screen-locking
> > > eventually kicks in, unlocking the screen still works, as the
> > > screen then isn't frozen anymore.
> > > 
> > > Thanks,
> > 
> > Thanks for all the information Paul.
> > 
> > Could test with the patch attached?
> 
> Applied and running with it now.

It has survived 6h without manifesting the regression.  Starting again
to try a whole day.

James

