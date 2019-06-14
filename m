Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D25C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F03720850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560520423;
	bh=iN+BVC7Js+mX3MoobKi+DcEa7AcS0a2jYmhECn22uIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F75Q4CHZHfuyuPMQNSAf1N/b3dO44RiMNIoJO3T67pohoc6iUoJXgfWWl/qUT/raj
	 lQpnRT/5K/m79Q7vad/VJcEw8X7Md4xu4twIIlaUvEVcNCchP8jshZlyFQQOq9+ts5
	 OtRe/7FLcS4RxqbFkW2JZXTVWMWYeMv7aE3ixcyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFNNxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfFNNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:53:41 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F51F2173C;
        Fri, 14 Jun 2019 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560520420;
        bh=iN+BVC7Js+mX3MoobKi+DcEa7AcS0a2jYmhECn22uIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbrN0WLSp6HT8EFxw2suvzAGJ2y4ugHSkmg9mi2F8dAUG/6+tN4RQD5uINI4GbA//
         X/MP8Dp6bgwd8NofNxmADhmut+aJJrUxzj31HIFSUzLPozkCFFxmQMQK3p8uKLZ649
         VmTupy0ZsiK3VwZ868voFn2Lzfg+71Q1DBn4ft7Y=
Received: by mail-qt1-f181.google.com with SMTP id x47so2483798qtk.11;
        Fri, 14 Jun 2019 06:53:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVO9BJPVMn9a+1phflmyBCaynYYNEIV8ZOmTHkDi/BZY1Lwnvly
        2F9kq+3Nj5zM4XcsyrfhBRNA63DAhSo/SFw+Mw==
X-Google-Smtp-Source: APXvYqxTD8kzLZOkPVP2CAljRyH/HAP/N5Lx3hq13DLW9NmQXLYZ+UmFKpgn9wwUIR0Y4foZTDrn8V2n23JvB6/KT/E=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr8626569qvc.39.1560520419707;
 Fri, 14 Jun 2019 06:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
 <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com> <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
 <41acc800-1ab8-c715-2674-c1204d546b4f@gmail.com>
In-Reply-To: <41acc800-1ab8-c715-2674-c1204d546b4f@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jun 2019 07:53:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+EVO9OiEK5bidywgKsfOCK+BgWvKehCNonqogegRfikA@mail.gmail.com>
Message-ID: <CAL_Jsq+EVO9OiEK5bidywgKsfOCK+BgWvKehCNonqogegRfikA@mail.gmail.com>
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
To:     Frank Rowand <frowand.list@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:29 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 6/12/19 10:00 AM, Rob Herring wrote:
> > On Wed, Jun 12, 2019 at 10:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> Hi Kefeng,
> >>
> >> If Rob agrees, I'd like to see one more change in this patch.
> >>
> >> Since the only caller of of_fdt_match() is of_flat_dt_match(),
> >> can you move the body of of_fdt_match() into  of_flat_dt_match()
> >> and eliminate of_fdt_match()?
> >
> > That's fine as long as we think there's never any use for of_fdt_match
> > after init? Fixup of nodes in an overlay for example.
>
> We can always re-expose the functionality as of_fdt_match() in the future
> if the need arises.  But Stephen's recent patch was moving in the opposite
> direction, removing of_fdt_match() from the header file and making it
> static.

Yes, we can, but it is just churn if we think it is likely needed.

OTOH, we probably want users to just use libfdt API directly and
should add this to libfdt if needed.

So yes, please implement Frank's suggestion.

Rob
