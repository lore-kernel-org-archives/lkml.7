Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E3C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GNi7HCFg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GNi7HCFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfGQV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:29:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34992 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbfGQV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:29:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C0D388EE128;
        Wed, 17 Jul 2019 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563398969;
        bh=LMTkdXUy9pZvZVK0Vg2eH0Zg70dLtAATv/rbKinbwF8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GNi7HCFgMCBk2AzqS5sYgoQ3TpY9KxE/r/v0e/0PSfo62ad3wnpO6ecI8HR9YjzGI
         0IqVoKVLcNraSKyyEUylvx6nn8RHvL7Hi2PMtH+m/TFPYrqMX7dq1gH96ra+ibBNs5
         /I2HIzb9cOrAplpEP7Nu9qJJ6iNUh1oUhlEliES4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4czQmuqH7-qZ; Wed, 17 Jul 2019 14:29:29 -0700 (PDT)
Received: from [192.168.11.4] (122x212x32x58.ap122.ftth.ucom.ne.jp [122.212.32.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 901038EE0CE;
        Wed, 17 Jul 2019 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563398969;
        bh=LMTkdXUy9pZvZVK0Vg2eH0Zg70dLtAATv/rbKinbwF8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GNi7HCFgMCBk2AzqS5sYgoQ3TpY9KxE/r/v0e/0PSfo62ad3wnpO6ecI8HR9YjzGI
         0IqVoKVLcNraSKyyEUylvx6nn8RHvL7Hi2PMtH+m/TFPYrqMX7dq1gH96ra+ibBNs5
         /I2HIzb9cOrAplpEP7Nu9qJJ6iNUh1oUhlEliES4=
Message-ID: <1563398966.3438.5.camel@HansenPartnership.com>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Paul Bolle <pebolle@tiscali.nl>,
        "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 18 Jul 2019 06:29:26 +0900
In-Reply-To: <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
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
         <1562941185.3398.1.camel@HansenPartnership.com>
         <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
         <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
         <595d9bc87bf47717c8675eb5b1a1cbb2bc463752.camel@tiscali.nl>
         <a10f009fc160f05077760ff59cd86a9c99006b39.camel@intel.com>
         <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 23:27 +0200, Paul Bolle wrote:
> Hi Jose,
> 
> Souza, Jose schreef op di 16-07-2019 om 16:32 [+0000]:
> > Paul and James could you test this final solution(at least for
> > 5.2)? Please revert the hack patch and apply this one.
> 
> I've just reached a day of uptime with your revert. (The proper
> uptime is just a fraction of a day, this being a laptop.) Anyhow, no
> screen freezes occurred during this day.

I'm afraid my status is that I'm in Tokyo doing conference
presentations (and kernel demos) so I'm a bit reluctant to mess with my
setup until I finish everything on Friday, but I will test it after
then, promise.

> So feel free to add my Tested-by tag to your revert. But please don't
> forget that James earned a Reported-by tag.

Thanks,

James

