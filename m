Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A2C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3320685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlX49lcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfDYUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:37:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40421 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbfDYUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:37:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so359975plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVBeA2JLgVaiAp63AdL4tOayuBNUpO5YOdjAlUuojeA=;
        b=LlX49lcBUNjCzfXH+SjHLW47Bp0UK8cxkFCauTrYt/y8xtqNR62xgDcR+r/l9a6J1D
         fKWD1SFHDaViQmKp6O79DB6Tn/6BqQ5ymk+Qo2GY+SbtOwbQR1FQHc1asqcdFdX+mXtu
         uIcTGpgpmurnQkbOyW+ElrGFFvewyGKo9R+mfcdGot0lJE7PgNyZiRiq6XwNxsuRQPax
         irGqHCnUOfHmxYYemSTjEYwJnNlOkMIaSFTBApACz1Weq0eAaS/NursFJEZIVZvhZoo0
         c43UJJ7gK9kKI+jFQM4gIS2pc5exrl5Iv/oFLrcKsWsuW92U7QvPqJOr0wN83T9K3gtl
         zivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVBeA2JLgVaiAp63AdL4tOayuBNUpO5YOdjAlUuojeA=;
        b=eOlsCx9JndtHrTxsYLiQf3b70gFoiJ1QTqs39h2kszB6VdHVSstKGihusf52XCcISB
         BqDBtSjZZ70vJ+3jatP+QxIwCDOARj7hUKhpIJZQ9J+YudrZSah8M6Ecb7SN6WEPtymI
         bOk/oi82X3tDAvh/D9rZItichh6Y+gMNsj4xXTmOCXmcQpbgOjushDqavhS+KdIC8g7P
         4tI9ainEWP6kZtO9W4Sh+qCvspBU4ee25ThMh/YVryZQJInWJhA+Ylgtaf3r41FEcbcr
         L10kjmh07xzGVIOFzHHh+Yaxy6nq+vzG7qhlquQMGEQRkp3IMgC0zagM/sQvBrrtvW5N
         viYw==
X-Gm-Message-State: APjAAAXn9NDWCg82d/3C0h/P50IpfQahZ2AMQUyOG3mQtAQSvCKR0Dya
        aCKY9FR1AQVlC+zIy3EHuw80PEIVqsDPOX74+UVTwg==
X-Google-Smtp-Source: APXvYqyKldxwAwWao0Hboo3eQyBykJneEOk/xvKt8IkJ7pae7NdIYomE5XLIBgnOyRvJG+Js8HrMOdkCjQZdHv8GYJI=
X-Received: by 2002:a17:902:2:: with SMTP id 2mr42008500pla.61.1556224660461;
 Thu, 25 Apr 2019 13:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190425202347.83880-1-venture@google.com> <20190425203652.GA23304@kroah.com>
In-Reply-To: <20190425203652.GA23304@kroah.com>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 25 Apr 2019 13:37:28 -0700
Message-ID: <CAO=notzu3P7b-TNzf9t1sZGbj33iZh59Md1pVg8OwS5yuQsDAg@mail.gmail.com>
Subject: Re: [PATCH] fixup! drivers/misc: Add Aspeed P2A control driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 1:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 25, 2019 at 01:23:47PM -0700, Patrick Venture wrote:
> > Fixup compiler warnings:
> >  - 108 warning: ISO C90 forbids mixed declarations and code
> >  - 264 warning: unused variable 'value'
> >  - 335 warning: unused variable 'res'
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
>
> Reported-by: kbuild...
>
> I'll go add it, next time please do it yourself.

Roger that!

>
> thanks,
>
> greg k-h
