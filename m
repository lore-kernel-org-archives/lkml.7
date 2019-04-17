Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBCEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383382183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KkYUGuqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbfDQWSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:18:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38923 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:18:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so135481edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kSf7XOwQlNrzig1/4ehRsu9PsSj4C1r+GPIgvRWrD8=;
        b=KkYUGuqeH7GJDvfF0XHzmfEctKO/28DX3dlsdOdsqfMeIQwiVkRZtNzc+MWSnSLm75
         mTrb28dLnfZirANnZwkfGdWF/O9+S0FPRAADA8Rf63czKu1gzYl8UYiAhTeQ1pWgVYQc
         4yqAnz6IE6bJkHKy4Q2BsILZ3Ma4KT6kdZ1BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kSf7XOwQlNrzig1/4ehRsu9PsSj4C1r+GPIgvRWrD8=;
        b=gwnhbL34M6QNO0h0tpZi/7CiJaspkD8ZZjl9mJR11EG6VLAEtLnFMQtbFH7cjzKOYL
         6ceKwhzANICPz36n4xlUj2fFaQtL6JZ0wD3c48RS7vknqPDLptpEcMu+VY/P1pcAEkQb
         Y2YmCCGY0iyxjPVlnkdPtDfY1Et1Hm7/jcq9MxDGpDlCQ3/5uaRdwuBWIUZblkhXTsLI
         XGm7iwbMrqdnw2cNlJSypPNP1OEtqrTfGh65QgSMi5C4ZmbVOi7h97E89QyVt+h1VTSG
         j2XlSvjQswsf6Ur2INZ2OAnaElBeR1lD7wRk4+jKJNysCWMuz2xhLmrClnvtw2jYac5x
         LHjA==
X-Gm-Message-State: APjAAAXacMDz6NBMYdG5qKLzYmMVHOSa1hKgGV21rzuOQa1C1YkiNEt6
        ZrxK5BzBQkNcv7Rw8IJQCTNOHsdmfEo=
X-Google-Smtp-Source: APXvYqxYrCWfPL1GX94GHx1C9cbs7kUIdFp+ogU4KEHcA5sG2BpR9Se/b37Xj/50d65gof2ndHi54g==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr1569940edx.279.1555539481811;
        Wed, 17 Apr 2019 15:18:01 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id i9sm10067edr.76.2019.04.17.15.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:18:01 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id z11so446614wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:18:01 -0700 (PDT)
X-Received: by 2002:a05:600c:28b:: with SMTP id 11mr508929wmk.153.1555539059258;
 Wed, 17 Apr 2019 15:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190417202017.GA204974@google.com> <Pine.LNX.4.44L0.1904171635460.1400-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904171635460.1400-100000@iolanthe.rowland.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 17 Apr 2019 16:10:47 -0600
X-Gmail-Original-Message-ID: <CAHQZ30B3+gzuw0=tofwW3yUwJ_MkN6GWPgVg0Qq_6S2tJHkcFQ@mail.gmail.com>
Message-ID: <CAHQZ30B3+gzuw0=tofwW3yUwJ_MkN6GWPgVg0Qq_6S2tJHkcFQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        oneukum@suse.com, Daniel Kurtz <djkurtz@chromium.org>,
        zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
>
> This sounds like a golden opportunity!  Submit a separate patch making
> the parameter to kobject_uevent_env be const (actually const char *
> const []), then submit this patch on top of that one.
So there are other parts of the code base that dynamically create their
array values. So by making the function take const, it breaks :(
>
> Alan Stern
>
