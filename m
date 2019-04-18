Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11378C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFCF214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM313Ela"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfDRTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:17:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35866 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfDRTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:17:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so1604935plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9IOoh+ojDuOZjVJx3eBsChtB80YQzisCQ5BSvwFzh/E=;
        b=pM313ElaIaqfLREkQdN71i43sENBBL14DMtrQ401ZHsZrlUFjq17dH5XS2k76YBGM9
         eh1lo7tRwf3QImePjxUFYK0Ldvn1fgzSwMJDGypDP1Ng3zoal4gh4fY+XHSYkNNNgcI5
         s03YG1Rb1gS/VEt+CyozsQ5gWWqaUf5K+WbdRUuL5ZPlqu9y51cwMo7OP6bjeQ4jIoHL
         pANxsPi+UzOO6CCPpbDYlGA+1oGiLsie/QU2b8XajhBE1iKY45y3MfNPvnisVvbAClEX
         h5ul4fLk5AK/IY8GdYdKISm97xYphKVeCXDWfGWjKCvEErKVtuoEJj/7tOuzIWTHBVvx
         LYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9IOoh+ojDuOZjVJx3eBsChtB80YQzisCQ5BSvwFzh/E=;
        b=ZFWAdXqu5fJY9lYzot2smctQclhXX9qgIjcUwNgVvIcJCzO53ReMHFXjKoWOLtGVJ6
         nW5v79Aj6S9UXfbV+d3+tuyGPwLxDwLNx705eriGEpJ3Qp7YxPg0p9Yl/5w/YU/ywd9J
         8OJ2f8L7Mzklgc71m4cW6Tj7JokO+7gq454PSQs5D6Ju3TcyC8yqOhOv9OIiKHP0D3Lq
         l4B8zLVG3k+rWXWc7vUW12E6kKdZu73oDXkFaD0s9xJMS23lRKgMuEvO1j+x4bhs7/cg
         UsbH7wS67ygyO2uYpxJF4Ktb/UEGH6Nppar4MQyVCyGueuumGg0cho9n0AUEOYky20z+
         5lIw==
X-Gm-Message-State: APjAAAU2cnLoLA5PK+kihEDYbXA8L2j77NCRcdIXKdcTEDBDiTeFmHHX
        4u4mN8+Ja58Y1BDAMdhjOmA=
X-Google-Smtp-Source: APXvYqxYBLCdan6vFoVsKEPBO+mBYiuomX4BdL/gbjarMJpuAQotjUwCG0p8kWR90D39M8W89YntYg==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr74984901plb.190.1555615035057;
        Thu, 18 Apr 2019 12:17:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o67sm3397539pga.55.2019.04.18.12.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 12:17:14 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:17:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418191708.GA14885@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479228E9CAE2A432D904BC7E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479228E9CAE2A432D904BC7E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:37:06AM +0000, S.j. Wang wrote:
> > > > And this is according to IMX6DQRM:
> > > >     Limited support for the case when output sampling rates is
> > > >     between 8kHz and 30kHz. The limitation is the supported ratio
> > > >     (Fsin/Fsout) range as between 1/24 to 8
> > > >
> > > > This should cover your 8.125 condition already, even if having an
> > > > outrate range between [8KHz, 30KHz] check, since an outrate above
> > > > 30KHz will not have an inrate bigger than 8.125 times of it, given
> > > > the maximum input rate is 192KHz.
> > > >
> > > > So I think that we can just drop that 8.125 condition from your
> > > > change and there's no need to error out any more.
> > > >
> > > No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported.
> > > This is not covered by
> > >
> > >         if ((outrate > 8000 && outrate < 30000) &&
> > >             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > 
> > Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz) in the
> > code. Then I think the fix should be at both lines:
> > 
> > -         if ((outrate > 8000 && outrate < 30000) &&
> > -             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > +         if ((outrate >= 8000 && outrate =< 30000) &&
> > +             (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > 
> > Overall, I think we should fix this instead of adding an extra one, since it is
> > very likely saying the same thing.
> 
> Actually if outrate < 8kHz, there will be issue too.

Here is the thing, the RM doesn't explicitly state that ASRC can
support a lower output sample rate than 8KHz. And I actually had
a concern when reviewing your PATCH-2, as the table of supported
output sample rate no longer matches RM.

If you've verified a lower output sample rate working solid with
the process_option function, that means our driver can go beyond
the limitation mentioned in the RM, then I believe [8KHz, 32KHz]
should be updated too -- that says we can do:
-	if ((outrate > 8000 && outrate < 30000) &&
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	if ((outrate >= 5512 && outrate =< 30000) &&
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {

Actually "ourate > 24 * inrate" is kind of pointless for range
[5KHz, 32KHz] but we can keep it since it matches RM.
