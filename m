Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4820818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C0byJPAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKKVJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:09:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39090 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfKKVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:09:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so2389569lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHSEG4DClXubyHOt3t2tdpDOQlrHJ64gHfdeM+gLICY=;
        b=C0byJPAHyBGELNR8VxwingUMAz9SgITb+A9AjnUdlNbZN9If1XFd42A9WqMnybvxSh
         0xLiQLCshpJ61VXki7XNugUcsdTCSnlP9Uq5ZvPtpwpXSh0oF/NEQUSxl30OzkfQZhqn
         1rf/q3MlN+w9M3x5JJsgY/AKPYTzGwbGoib87YokicnBfZgpLs1wXPr9Y9SpAD004Vpc
         6eDlSOScgt1RgLLp75LmDJ1HFnQwHPq2IYG+5NGSbdCgOJG4spodRKfaDMd6ziILXev2
         RIhm/RbObZ1Dj6FfGK7ro1/9OeFAFam69eF05Ix8bUzPjkHTLXqiKHkU0rFiMpVWLzrf
         Y+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHSEG4DClXubyHOt3t2tdpDOQlrHJ64gHfdeM+gLICY=;
        b=jeJ5lsPzhEe4GKDe5ZOi2ORQiKBplbiyVHRkPoWDDrQ02xejOL4cEwIhTlMYk0AEfC
         ROUj7dUlp8A0aslimPG3NcRzIefxQho+IG45525L6KDgeQ+gVWKTZhoY9d3hVJ4TpF6f
         mJnu8fFNVgUGMjtlkQWrAN+AinJsVC9HexwUzVFQLr4RXXaymtfdEy8/djH/UCuEqv0M
         uGSkJrDoNrf/RnQFuljbrfGPOEK6dzlp3rASyK+dM6w4Pksqz30CqVFPCsv0CGPHL7Ba
         1+SZfaXj+EjrtXtQhHJcupFpFaTyIuJ2b8AP8iHDfC+ZtF1fTgfzANz0voVG44m9yqaF
         8QMw==
X-Gm-Message-State: APjAAAUyS77FVaMQnolSK5GcnV/NjQvdRS86NcWkZdaHQLQQ0DevO3m6
        3CEUI0y3ZgMZondciiaw+cgo+exC9jBeXh7TFe7JFg==
X-Google-Smtp-Source: APXvYqyOV+qMajgujL1ZnUhT/5i+HYiizrcV+RZBGO/EpSCa9X8F8143Pct1qwA+SxxRp1H6OvOStCg/EzXoXYMk7qs=
X-Received: by 2002:ac2:5305:: with SMTP id c5mr9157574lfh.55.1573506568166;
 Mon, 11 Nov 2019 13:09:28 -0800 (PST)
MIME-Version: 1.0
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com> <20191111203743.GA25876@lst.de>
In-Reply-To: <20191111203743.GA25876@lst.de>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 11 Nov 2019 13:09:17 -0800
Message-ID: <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-nvme@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 12:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 09:38:09AM -0800, Alan Mikhak wrote:
> > A design goal is to not modify the Linux NVMe target driver
> > at all.
>
> As I told you before that is not a "goal" but a fundamental mistake and
> against the design philosophy of all major Linux subsystems.  Please fix
> your series to move all command parsing to the code based on flags for
> fabrics vs PCIe in the few places where they significantly differ.

Thanks Christoph. Let me repeat what I think your comment is saying to me.
You prefer all parsing for nvme command received from host over PCIe
to be removed from nvme function driver and added to existing fabrics
command parsing in nvme target code with new flags introduced to
indicate fabrics vs. PCIe.

Any more thoughts?
