Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC445C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D6924249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575555998;
	bh=B44m5w38XqeeZeyxOxvTz4RjVYRgjbWKm12VoLmYVt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HVU18hoasG4e/BHBRfD9XO5uX/6OUQ7Z07G/8Kc24kYHVdY25FFqtoLp2+w/B+6Y5
	 ElrfFcTdh899YTLfRUx22mbLwgdOsDvZhR8xMrmvp3BFacBWrj8pj6wkmW4IzYJOLm
	 aCgieLnUhFM4x5JnPEOK9QKbnPfdWEJRb+nx6iuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfLEO0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:26:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45116 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfLEO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:26:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id d20so3761253ljc.12;
        Thu, 05 Dec 2019 06:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPiOMjJ2rQ9P8n4Ma3k63SEaCRn4xx4awe4inxl+t/I=;
        b=aN3wqPjMXvVUeLwYiWDFQgknsauXIVhiRmKFhuUwjKM8TXtkBYr42qJv9nVUiOCsoC
         pGPvVON/Hy9K7wvQvm6un9dAFB6CPLkK458w4GwgRr2+yFgDoG0ERsUf3BoULCRaO+Tj
         WkjW41jKYCISxActDbz1Tal5cjQ/F6bSexV7590+sWSR3hAbk5l5888/kNqVMpqZA1GY
         DAgodg0KrFGhub9KfvsFf8MpAGMA6C8BZ1r+aNE8mlkfVVYA/SKSEeVBCqXqp9HkNeQv
         3dFgE8f/DetikoqMttME7wqSjjbq38ALW4QDzJTtB/A8ilgTXFuSHbMm9YO2WHIeq3iE
         l+Cg==
X-Gm-Message-State: APjAAAX49iYT6acaHrTpAyalWGarr6Kq4BjICoHT1cMpV9hnLPN8plTs
        hRrQKMHHf2oy/34tpoxd7Aw=
X-Google-Smtp-Source: APXvYqzb4cLM/qctOgqo1PA/b3FzFA5gxEnEqCCSI8qwFiyJ8WN0zrZ3X7VCu0P4Lh5tl2rFEtEQRA==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr5836966ljc.222.1575555994820;
        Thu, 05 Dec 2019 06:26:34 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id x29sm5866487lfg.45.2019.12.05.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:26:34 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ics5Z-0001Kf-0i; Thu, 05 Dec 2019 15:26:41 +0100
Date:   Thu, 5 Dec 2019 15:26:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
Message-ID: <20191205142641.GL10631@localhost>
References: <20191203101552.199339-1-ikjn@chromium.org>
 <20191203165301.GH10631@localhost>
 <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
 <20191204075533.GI10631@localhost>
 <CAATdQgBcuJenS2VSm+y4Yhn5mWE1P0CGJQ3NRdoe68dd2SRPGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATdQgBcuJenS2VSm+y4Yhn5mWE1P0CGJQ3NRdoe68dd2SRPGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 03:32:38PM +0800, Ikjoon Jang wrote:
> On Wed, Dec 4, 2019 at 3:55 PM Johan Hovold <johan@kernel.org> wrote:

> > But related to my question above, why do you need to do this during
> > enumeration? Why not just set the lower interval value in the hub
> > driver?
> 
> Because I want device tree's bInterval to be checked against the same rules
> defined in usb_parse_endpoint(). e.g. although hardware says its maximum
> is 255, but the practical limit is still 0 to 16, so the code can
> print warnings when bInterval from device node is too weird.

But that could be handled refactoring the code in question or similar.

The fundamental problem here is that you're using devicetree, which is
supposed to only describe the hardware, to encode policy which should be
deferred to user space.

So I think you need to figure out an interface that allows user space to
set the polling interval for any hub at runtime instead.

Johan
