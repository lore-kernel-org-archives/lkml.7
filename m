Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C994C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D51D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="raAxo0et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFQMA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:00:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34480 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfFQMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:00:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so9041440ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nleIE9ePi5skSHo052Xl0bardtZ3IpqSGXLP+XjhobU=;
        b=raAxo0etEdipbUmleEts6OLEsC8B1ii1er9sNc53iO+ucv+O5CUPdOq4zQP7ZRoiPQ
         S70dn0e+SLyL8AJw86Gt23gG+NnaO9yUebcrklSUqq2roiPX3JefNWuL13UXDON5t9Fj
         yf/0xULOgk5brkXPCp5al74EGEI3mO2hiQ8mLfwF3eOl6NUEeZqzMb7SXQ3nouaPNzwO
         RAIu7PygtuwmShhaSLY2RqsICL06qpkLvGKgGMRynXIBZIlua4hAsp6VGNfcAWSQz89J
         0flWSgUij5FkXsa7S8O9I/FBQPdg8i+L9tWck1Y1EJyYHL2iM608ggVjMDmbr3+/HxtE
         oLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nleIE9ePi5skSHo052Xl0bardtZ3IpqSGXLP+XjhobU=;
        b=jIk81LEWBou+zjPD8kgWViSDatXUv2QO4nGVORqCOeZEyMqz+NwymHHeT/0TBUtpKf
         VMBFd74Y7PDj4+V6WM+z3+FsALW7DMa5990tF+1/6p/wrIsLxuCZ6bcsjD/nr9MAvRIz
         KUNImx1TMuUBIoPNw5KJrauIXFIH8Cm/ZNhmiKpRHyKdO5LBx9r3Lc+RC+FxpVeM1FiL
         NAQCLgYtdgYbUx6/halHPrrKB2DvoCJVDt0f4baD8Xl0oWPae15tI0KkN2KLlAv92Pb0
         WHfBJtxqtxfoUOqOirrvSu735vKxkeHDE/mx2H+bIaBzrTo/Da6V9iPFQwbF3XqhhVwm
         raUg==
X-Gm-Message-State: APjAAAWSUncQPcQgeUwr82qYlRZvNXKrkbtlSzhBeNA0lZhYz4vP4vqb
        /71W02AS1p1YbstyQiF5naZlxw==
X-Google-Smtp-Source: APXvYqyvY+d9qaHyNXcrAGDLi4O4nxgI3uhriSPZBNVI+IjOaAqBEDljJgrhSL887w+/AyzyjVHasA==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr49607117lje.46.1560772852116;
        Mon, 17 Jun 2019 05:00:52 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n1sm1718747lfl.77.2019.06.17.05.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 05:00:51 -0700 (PDT)
Date:   Mon, 17 Jun 2019 04:49:48 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Message-ID: <20190617114948.7xxtpivve52c2jnb@localhost>
References: <20190605194511.12127-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605194511.12127-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:45:11PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> This is a rebase of patches that missed 5.2 merge window together with
> some new patches for QE.  Please help to review and merge it.  We would
> like this to be merged earlier because there are other patches depending
> on patches in this pull request.  After this is merged in arm-soc, we can
> ask other sub-system maintainers to pull from this tag and apply additional
> patches.  Thanks.

Li,

You never followed up with a reply, or removed, the previous tag. So when we
process the pull requests that come in, we've already merged it.

So, I've merged the previous version. Can you send an incremental pull request
on top of that branch/tag instead of a rebase like this was, please?


Thanks!

-Olof
