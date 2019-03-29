Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95316C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B190218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fxx72nOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfC2Tpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:45:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfC2Tpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:45:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id b11so1485452plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rt/XZbu6kOM9x2vXlY6ECOlA0Nw9mNr4Yr37/Rjkef8=;
        b=Fxx72nOlnCAIug1xADInmbAg4WzR+IlSYnQj++SbTxe7bP9V6FsgoKAHGOjjHjoHKU
         v8Nj3VW9QoQTj4GF52Y1hy6PoICg4SskuDdHoCxxQjka+vA7au8T6nxja3l/l6HNcJdB
         mj6K7Y26kHMfik5cE8XmBaRiDrG1eMYC5Ndi95sF3AyyEIIocA8LSeM5SQOH5FVlntaP
         SMB8SDFywmDHYlWF5edtU27zZ2iqBSSkhm51HSGzUWCFzOhGBSwpf6tVE0hoqndEbBvS
         /T/kWNFVsyfAkSmaQy3E0b0ABiEolW+vC/9cF5HIt+Yt0GZlXBOJB1USD9lkYa1x9DHQ
         lMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rt/XZbu6kOM9x2vXlY6ECOlA0Nw9mNr4Yr37/Rjkef8=;
        b=fH7T/ElZbiKG9MXtUZc7bYFJD9qXUdO2FmIDL+uMOQJWmQQYnWAgkYDiz3f+i/dwXj
         m7IXPAFE3GSrww9FzOY/Y/2nfVXSNmm35ce6tJsx1rDDBkx6cB/AClccr6PbJrISy7gm
         B49pNgQjkOiXMYewmGsBohfwmsrUp0J1cVmj+FTCEs8Dht3plpcwllh5n7mWK6DAdU3K
         DZzNms2lNdDhDKiajAAoclZriGlGGBkPOQph5vc69Fdhxy4hGk7ZC7pfjSXc0o8kAep5
         2gc1zUK5T/wqosCBu1VgImweMchrp7aq6EF1BvQrNYOjOpKPupvl/7xN2k5kh0BAp55G
         Dy0w==
X-Gm-Message-State: APjAAAVhXl62quuxg1QoMZ957Sqgnf3L0lr1J1zn7yJA67nM4Hc2zOg3
        trkB+R9FX38LU+6igtGks4rjRQ==
X-Google-Smtp-Source: APXvYqzES+9scXQSzH0kx6SYjNeXxv8Dp6tjcPCTNsdRGukpMT77edqnvIumCu6NUJtWNLXl86tZzw==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40mr50560241plg.20.1553888734728;
        Fri, 29 Mar 2019 12:45:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s5sm3781713pfm.184.2019.03.29.12.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 12:45:33 -0700 (PDT)
Date:   Fri, 29 Mar 2019 12:45:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-edac@vger.kernel.org
cc:     linux-riscv@lists.infradead.org, Yash Shah <yash.shah@sifive.com>,
        james.morse@arm.com, palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
In-Reply-To: <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1903291236060.6637@viisi.sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com> <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Yash Shah wrote:

> This EDAC driver supports:
> - Initial configuration reporting on bootup via debug logs
> - ECC event monitoring and reporting through the EDAC framework
> - ECC event injection
> 
> This driver is partially based on pnd2_edac.c and altera_edac.c
> 
> Initially L2 Cache controller is added as a subcomponent to
> this EDAC driver.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Based on the discussion with Borislav, we're going to move the L2 driver 
elsewhere in the tree.  We'll look into creating a platform-specific EDAC 
driver on top of that.


- Paul
