Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69B02146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555016166;
	bh=uGwDnoUmnQ2QF3hLsoeFHC5G7i8i58jClbk//1BVhlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j6uRwA9oIjhviHmqvRSEoBatEYMegLIK7eJ8SHPUoPRCcFx54bAABYs2LJIKAjXLm
	 Arho9I6yjOYrj78+KX7bcFGL4rnSR5TbsLUXj7ibEokaP5AsJGcRlUKlqwkINtK4cK
	 VCOpR7feysGJOP+Q4wprPN5JIEF3WnngWGrSXa+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDKU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfDKU4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:56:05 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E9B2146F;
        Thu, 11 Apr 2019 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555016164;
        bh=uGwDnoUmnQ2QF3hLsoeFHC5G7i8i58jClbk//1BVhlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=McAfCNcHlZV6uKP5E6njmNNWiUUswPNmvoU1aBL0o6BuEDCFeHXGGqjdoXRf3ey3D
         vVImOPHlY4Kaa73jeSv8SIWIaqtCKMS52EEPtWnR1MKdiG06otbiGQSCaPqJ2gNAHW
         HaSPlvHcAH1jyb82S/9yUPhqBODh2gw1tcQWXvI8=
Received: by mail-ed1-f48.google.com with SMTP id d11so6441288edp.11;
        Thu, 11 Apr 2019 13:56:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVG43Sl6mJvKgXGEjcN21cjvBVWXjpgsoW+qfcIy0weHXjgx3eR
        5qu6LhQTle3FJYZQgXOftnWBOWJopk1eJPssWd4=
X-Google-Smtp-Source: APXvYqyBBihT2Q08LyY3UDOvfCgjFfL+CF8sauzIWbQmIthaLX5t6uU8w4Naxy4fzTNAqlvsxz7xvyzyyy6tPPA+tzw=
X-Received: by 2002:a50:a4db:: with SMTP id x27mr32880544edb.120.1555016162985;
 Thu, 11 Apr 2019 13:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-10-git-send-email-hao.wu@intel.com> <20190402150956.GC15773@archbook>
In-Reply-To: <20190402150956.GC15773@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 11 Apr 2019 15:55:26 -0500
X-Gmail-Original-Message-ID: <CANk1AXR18fv0U2fYa0dOtCL3oWkgp8Jf74JULAvigivz4o5irg@mail.gmail.com>
Message-ID: <CANk1AXR18fv0U2fYa0dOtCL3oWkgp8Jf74JULAvigivz4o5irg@mail.gmail.com>
Subject: Re: [PATCH 09/17] fpga: dfl: add id_table for dfl private feature driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 10:09 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Wu,
>
> On Mon, Mar 25, 2019 at 11:07:36AM +0800, Wu Hao wrote:
> > This patch adds id_table for each dfl private feature driver,
> > it allows to reuse same private feature driver to match and support
> > multiple dfl private features.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
