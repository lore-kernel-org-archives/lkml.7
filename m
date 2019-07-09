Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D4C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BB02171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562678748;
	bh=2Pu//gdRw8xl7g3w+j9PqFIaEyA7c1GFTHnPsYQLEfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JO2MO6RJZJttFOrlTAvazk3IpLcIFmdmHzrLm23HLgFm6sNkZOXjXQj93qODNYxKH
	 JD6FAzy6H5iVRkpZBGNxkZlCy8hAFb8sUBWMRVUZvFSS+iAENp+ge+xdckgK2UVI1e
	 2WiSzIgPKn876iuWQNHpAfEbCbZJL+ZMM5aYy4sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGINZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfGINZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:25:46 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F73217F9;
        Tue,  9 Jul 2019 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562678745;
        bh=2Pu//gdRw8xl7g3w+j9PqFIaEyA7c1GFTHnPsYQLEfM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OzzxHCoo1uBNd3c9YxIPGssh+/Jx2PVbGQT9/Bh2m6tY/G6FckB4NNCB2m2Xd/uZ2
         3lMUZhSIRiIkijEOtWoUPMP6/uIYS4AYfAsHWAiaX/sJ7a7qMp/Y9sCVUv+MsOK86P
         wlPirOz+ColfHRQn5wqZjljqN3JMmdlfld92YBK0=
Received: by mail-qt1-f176.google.com with SMTP id j19so21527974qtr.12;
        Tue, 09 Jul 2019 06:25:45 -0700 (PDT)
X-Gm-Message-State: APjAAAW6N03eN+Jt5fOwrD5S9sZfLPIGV0aDALNZjC2tw+D8VIPqTy40
        GfNbSz0rApvZvEzeyugZLLLT6Gl5BSTZrqkjvw==
X-Google-Smtp-Source: APXvYqzNgeDDk6JGVfv4FyCVfvJ+ZYxm57dh5Q1YBNuhIpjWSbaApc03TqOi2O1VrurMm3HooVZD1GBjAucXOFEk5aY=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr19486021qve.148.1562678744997;
 Tue, 09 Jul 2019 06:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
 <1560155683-29584-2-git-send-email-talel@amazon.com> <20190709022301.GA8734@bogus>
 <f1fd393d-0b8c-16f1-9ac2-0589e9cb9ea7@amazon.com>
In-Reply-To: <f1fd393d-0b8c-16f1-9ac2-0589e9cb9ea7@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Jul 2019 07:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNWAw2LtCvnsDkrUTmk-Vy1ncwR4XuCN7=_Sg8vbTr2w@mail.gmail.com>
Message-ID: <CAL_JsqLNWAw2LtCvnsDkrUTmk-Vy1ncwR4XuCN7=_Sg8vbTr2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dwmw@amazon.co.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        jonnyc@amazon.com, hhhawa@amazon.com, ronenk@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 12:00 AM Shenhar, Talel <talel@amazon.com> wrote:
>
> Marc, should I publish those fixes as new patch that updates the
> dt-bindings or new patchset to this list?
>
> On 7/9/2019 5:23 AM, Rob Herring wrote:
> > On Mon, Jun 10, 2019 at 11:34:42AM +0300, Talel Shenhar wrote:
> >> +- #interrupt-cells: must be 2.
> >> +  First cell defines the index of the interrupt within the controller.
> >> +  Second cell is used to specify the trigger type and must be one of the
> >> +  following:
> >> +    - bits[3:0] trigger type and level flags
> >> +    1 = low-to-high edge triggered
> >> +    4 = active high level-sensitive
> > No need to define this here. Reference the standard definition.
>
> This device only support those two modes.
>
> This definition tries to capture the supported modes.
>
> Should I just state that those two modes are supported and then avoid
> the actual bits and values?

Yes.

Rob
