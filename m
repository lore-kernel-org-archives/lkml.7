Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C161C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7972189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWa4pc2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGCQqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:46:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46591 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:46:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so2715962edr.13;
        Wed, 03 Jul 2019 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=08FT7ddsmk9tLgvVvr2oQycyQXe5HFBk71BAZ/FmXUk=;
        b=TWa4pc2EdmtLNNbcdyQZTBp7Y2NNRNhRU25KJV9GQNIpuMKkvzYyNvnWH7nRRamPjb
         /caum6h7iO4vYiEkff6fwK5UakxNxnG7joCZz2ztHg18jvm1EzUT1MVhQUAdq6q6nmlh
         82j59LytSemhPZWkaRojDdtxLTfmB0aT4QJc8vxqebnnxqkcQ6Wtz6QBDJXsWnnofHPh
         2WF0ehgVKHOIAaLQ6W69V8wxdHlaBd0SOTcldZ+6dWpo3IR2VBG8l/WRdWfnpOcQFk7Q
         KkRJJkh4BFNw5XmVgmjlpoBmP5BhcLKyzDbmUjJ9zdsbCCnt6JHPtnNQj0qqrIbVFNEh
         aSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08FT7ddsmk9tLgvVvr2oQycyQXe5HFBk71BAZ/FmXUk=;
        b=RDaClSbQfRLYE20Dk1rFemvNCT6J85jjJkARjX1d4yJOoiYkjgo4tFFzdUslrJ38wC
         fVEjp7ITyXu+TBMDlqFbhWsg3JsedUweqSIvyPYislVFcyrh9GQ1LuuuVEAnWfs8jAfu
         fb3eECwYXZ7AdyRDemRWGYSI9pekRfHzQfWbNbPlbNxGP5T60/SOdlurXAIiWJg9ojvq
         Y7+7AvrAs2Yeh/yJc5gHBjdiQqUvQWKGZx5XbXXz667AJKyCBePeMO8q2gyQ8LZerayJ
         +MSIrzDQMxOLFMUe6NJu9njS5sxsqxNv2IXbx1X1dlARF4KAv5eYLU28KGLa9Z6iagN9
         fyYw==
X-Gm-Message-State: APjAAAV/xjrn2G7FD1swYAx8ZbAvt3Pap9Q3Wj8fWJev6GXJX3NCbHgG
        W0sVCHNqZ4nhuWDoqAZGyB0=
X-Google-Smtp-Source: APXvYqyQneHl9k0YePcXIOIWu0hzBiE7uHghqSPjYIrF6KJ/fdAgv7pH7XVLT+Hdo0nRWBLT+8kdhg==
X-Received: by 2002:aa7:c754:: with SMTP id c20mr43184865eds.265.1562172363746;
        Wed, 03 Jul 2019 09:46:03 -0700 (PDT)
Received: from localhost (ip1f10d6e1.dynamic.kabel-deutschland.de. [31.16.214.225])
        by smtp.gmail.com with ESMTPSA id h10sm845881eda.85.2019.07.03.09.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:46:02 -0700 (PDT)
Date:   Wed, 3 Jul 2019 18:46:00 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/2] Variscite DART-6UL SoM support
Message-ID: <20190703164600.GA9261@ripley>
References: <1559839624-12286-1-git-send-email-oliver.graute@gmail.com>
 <20190613013830.GC20747@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613013830.GC20747@dragon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/19, Shawn Guo wrote:
> On Thu, Jun 06, 2019 at 06:47:00PM +0200, Oliver Graute wrote:
> > Need feedback to the following patches which adds support for a DART-6UL Board
> > 
> > Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits
> > 
> > Oliver Graute (2):
> >   ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
> >   ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
> 
> It's already v3?  I did not find previous versions.  What's changed
> since previous versions?

The first two version you can find here. I splitted board and SoM part
according Neils and Fabios comments.

v1
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=59259

v2 
https://patchwork.kernel.org/patch/10748361/

Please review the latest version v4:

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=137257

Thx for your time and patience.

Oliver
