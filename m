Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA9C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amCjD7vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfJNHGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:06:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53627 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfJNHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:06:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so15955214wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UcX/K78ER3Dpsa0ml417JDI1Bq3FjChmJ3LPYy/yohs=;
        b=amCjD7vqHlFPP+CqdTX3ndTm1LACNykC25KuFYG2+iyoWHnG9r1YckLnq778K7EZ0h
         K1Jqe8aojfxf9DTi+s9e0klC6pD2kZTat3fARE42D/PcNlqScpBR+m3yjLidrW6RP2k6
         5phZpxyflxA3IMr/8UfgorCRmyx/TRORnABIRCknFXnG13AMTveXoX681VVePX/+rrjJ
         xkWNC3ui+CdlcqXF6tV46tiKeNycRJF4hUs7SgcPBtpTbo7PtcyLB9a+hJ/mMto3wYBc
         +w5ki3UwWVL5118qlPDstXVvgW1+E7BPAG/PU1s0rxSKA/bSon5Gl14MWSrUqPD6lQRW
         UaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UcX/K78ER3Dpsa0ml417JDI1Bq3FjChmJ3LPYy/yohs=;
        b=XRXPVzMhhFolu8To3c71+B9Xw8z6nPF+yNKJhCDKatRoRuqYEN2jNsqaiOD3kV0hJE
         wPB0AJd9qZRy/2wjUWV5z8eBiEwiZyKVEn+IQSlRe2vGgljL0i4p1hT/BCbhC/L+hPsk
         /O1dum7ZB7p4lYC+9EgnNekJYS0A8Uhe1S4xvDempZyUt5QMCKVpL+vndQ2CeUps1FGB
         GfNOgb27CB1CL+2RTJTLFIU3+cT5cTWSbZxSX05GQUpGu011TLJcWKB3vK2+zNLUafA7
         0GNeo0a0oVk6PHr4Q3kiMh1EkElkKnoGsFjkaUNE6lF0O7QXndJuQpbjKdf8aJhVbUDy
         fwlA==
X-Gm-Message-State: APjAAAUBYNJ4nEk6oVccG9o20j7XhIukfIy6HzmS+58wuy1rnjKQnXBs
        /Yin05duXhj1+q4qsPtjsqQmgQ==
X-Google-Smtp-Source: APXvYqwSAXMAVJkBBmqWnTjUKWh15LDVBrP3t3czJZNqxyprorYmj49JypUYi73a5ki+n8t3UhVqwg==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr13304138wmo.146.1571036765197;
        Mon, 14 Oct 2019 00:06:05 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id t203sm20090554wmf.42.2019.10.14.00.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:06:04 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:06:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v3 2/2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191014070603.GD4545@dell>
References: <20191010030335.204974-1-ztuowen@gmail.com>
 <20191010030335.204974-2-ztuowen@gmail.com>
 <20191010120823.GD16384@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010120823.GD16384@42.do-not-panic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019, Luis Chamberlain wrote:

> On Wed, Oct 09, 2019 at 09:03:35PM -0600, Tuowen Zhao wrote:
> > Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> > in MTRR. This will cause the system to hang during boot. If possible,
> > this bug could be corrected with a firmware update.
> > 
> > This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
> > by forcing the use of strongly uncachable pages for intel-lpss.
> > 
> > The BIOS bug is present on Dell XPS 13 7390 2-in-1:
> > 
> > [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> > 
> > 4000000000-7fffffffff : PCI Bus 0000:00
> >   4000000000-400fffffff : 0000:00:02.0 (i915)
> >   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> > Tested-by: AceLan Kao <acelan.kao@canonical.com>
> > Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think you'll want to Cc stable for this, as well as the last patch.
> LTS kernels with the ioremap_uc will be able to leverage the fix.

When you re-submit adding Stable, you can apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
