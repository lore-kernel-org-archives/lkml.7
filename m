Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7A2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555015595;
	bh=cg6vcRjYqVcEyWsUirUouCQgdhJHP6oU47vPazrG16U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hns2UOVwIwCVxayxIyYHnu/7s/r3XEC2+MM4xG0iuAW7fIEurnqEZZ+6QGnlmC66P
	 4JA+4WUs2OZtJ2Wj0m2Q1BoSRO3nBNgzmULrdJlNwXD/CA+w+XCGDr2fdfH4uXIsnD
	 3m6LH5J7ZVR6rJ00185elPJ+9GJgFkTwsogJldv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfDKUqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDKUqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:46:33 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4BF82184B;
        Thu, 11 Apr 2019 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555015593;
        bh=cg6vcRjYqVcEyWsUirUouCQgdhJHP6oU47vPazrG16U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jtD7GF5rER/OrGa9DxdXzr5+UQgoejPF9vThO0T7hyIRhF7eByt0EpFY4dNuVH1X5
         Q/wFvGXbcMbgB3/Qo1J8Fw2TxfmPjd1jItDrOKWvwcyISbOseuF+wqqVg+4ZYGks2R
         yLuczRS9XH5DZl7sN/Dyuc8azFqv9ZNRwWZW9HC8=
Received: by mail-ed1-f47.google.com with SMTP id d1so6415909edd.13;
        Thu, 11 Apr 2019 13:46:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXXFCtuLRUIqPwuP8LeaNAmVg+Qbq3Ur/NfEDVOXqtEd4FEtJdb
        otYF8uYET4NIjcBDMcJ0N3hqNICD/46xFwf88EA=
X-Google-Smtp-Source: APXvYqwdGi+g08MWa/C8/lAdqwPsfRMx4ENOMIEfpA370lVui7XWA1RgILRRJI/7i7izFCFfDUzbSXJDpDBdWiNKg5Y=
X-Received: by 2002:a17:906:69d6:: with SMTP id g22mr4079340ejs.124.1555015591393;
 Thu, 11 Apr 2019 13:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-11-git-send-email-hao.wu@intel.com> <20190402155018.GA1453@archbook>
In-Reply-To: <20190402155018.GA1453@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 11 Apr 2019 15:45:54 -0500
X-Gmail-Original-Message-ID: <CANk1AXRuA=hWOSxV-z9h3oz1VQVTVy8tYe2pgi4qN0fz9u2fyw@mail.gmail.com>
Message-ID: <CANk1AXRuA=hWOSxV-z9h3oz1VQVTVy8tYe2pgi4qN0fz9u2fyw@mail.gmail.com>
Subject: Re: [PATCH 10/17] fpga: dfl: afu: export __port_enable/disable function.
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

On Tue, Apr 2, 2019 at 10:50 AM Moritz Fischer <mdf@kernel.org> wrote:

Hi Hao,

>
> On Mon, Mar 25, 2019 at 11:07:37AM +0800, Wu Hao wrote:
> > As these two functions are used by other private features. e.g.
> > in error reporting private feature, it requires to check port status
> > and reset port for error clearing.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
