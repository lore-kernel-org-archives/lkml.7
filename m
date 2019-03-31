Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6917EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3896A20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014542;
	bh=vkBMUmCWC1aYa8CQidNSeL0BUmiNaS+yZvfTpfeNNSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QBuN5blpqo2rVF+8Rrgy8IJyjY8VFEvOz9czz8FIQ62gBIscOmA7rRAZ09wFwX4OU
	 +KUa4dxQ6/n/jPgBj2F3LmKrVbXdbLPg4+am2yqt0ik6R49DYGA0YW3H35ODCA4DVr
	 sA7xWiQRrBTK6Iq2kySInrY0DBc6TojrY54NwSLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfCaGmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36692 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbfCaGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so1729521plb.3;
        Sat, 30 Mar 2019 23:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dt/ACjhZiVFNzLUbsihwNwyMCyKRYDORtlpDp7lddZw=;
        b=gElYS+rcOmcNACBkJteREbcBbbDa8DtJ15KXmsSE/4gQvKrv4HRml+YJGqJiIH7CQj
         LZy0W++07V2BTJ8rBlTU+7viQ/Dgds5u8iVQMPAzgECjAJFcZx50+uw1uUOuo23JsKsN
         fAWH82Gtz6jZYfFg6JTBv60NkU/0/sYrn4T+696MQn+xHY4aebjJvBFOwvqUj8T4j+xj
         +JfISxMuKfKMi/WgXjz3Ws3PolFFc13uPzoRrPVAt4dcRREvO/ZpUkhkV8muuNgHtp9J
         79c4IIlQH//wSDQZkowzKtDKFyHyC4XkTlLpt+Itqzrdj2iJEHibi71gR8/Dx/o9epFd
         DSZw==
X-Gm-Message-State: APjAAAW3X08sCA/uVkt9ASjVUoD/RKWg12moohDKQrb+tVi69lMdKEGe
        M74629uGU0iRUc1Vof6gzUrT0vpxqw==
X-Google-Smtp-Source: APXvYqxOLOQYtW64ydSzkZ43gnXibv7qITPApysD8bRNNg3JekC6l0ZKGlGcbohXrBT7TRKgZpt1dA==
X-Received: by 2002:a17:902:1486:: with SMTP id k6mr57018841pla.3.1554014536105;
        Sat, 30 Mar 2019 23:42:16 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d69sm13124273pfg.26.2019.03.30.23.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:15 -0700 (PDT)
Message-ID: <5ca06147.1c69fb81.f8db8.1219@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
X-Mutt-References: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> The prefix is used for printing purpose before a node, and it also works
> as a separator between two nodes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c  | 22 ++++++++++++++++++++++
>  drivers/base/property.c  | 12 ++++++++++++
>  drivers/of/property.c    | 10 ++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/fwnode.h   |  2 ++
>  include/linux/property.h |  1 +
>  5 files changed, 47 insertions(+)

