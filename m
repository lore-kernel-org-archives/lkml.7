Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E615C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFB72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZkVAOYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfDZXdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:33:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33733 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfDZXdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 19:33:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so1409939plp.0;
        Fri, 26 Apr 2019 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EVawrH3A/AolTp0KCLsC366YcDujvZT0dOEF2SwZx4=;
        b=cZkVAOYeIcVia7mB8xN6r0xiE6jKEzJZ7bmghHXHk9By9PdltxoKIuSjJRCEPn0Yan
         yA9iEvfXGcl3biBtThS2w11KqmkZKoB5CZG1d4aeNHYyXa2xIJD0j/gA4f1jDuaySrW1
         QzKNQh0UtTBbdkTTccP7BZvN+Sm/8/e1359Cc7iWWkPkZqzyAZaaFcD1CHD7a65wSHvI
         zFBwRmqV7lxA3709sNlMQDOSDV5Be23XOTYd+M0a2C5wzYQBWfVNZ4KvGFL0XV+/ONn6
         kzJTWL4I+QDIvjMMmVZM8lWYu8TPXKJ1fGvIS3ma5wLwN6+3AA+htWaWtmOQ7MzWiTCO
         vQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EVawrH3A/AolTp0KCLsC366YcDujvZT0dOEF2SwZx4=;
        b=U6IUWkB7ihXGr5+DtUE3p3y/hwn0U7+4ex5FpUPpjx40ekNNiT8HUEopZmuvpxdu8O
         FSPUM5bUC6cP+25ItdCSKzIuUlSFR5gVWdFhblJOcIoWYSm0MLTECw65Ere8g17Za3/q
         gfTrXErR04QahSom8bjfhZ1ZVuT2qYzrUVpr+WY5Rc0N9Bxja23PT11SZHwp0yYQQrTH
         Lpolg4tRfInVk5JFIQAa076xHq8f0gk80JAbDFnUxczFOwCAjc5gVVEIXqdrGpZUd4of
         HMBikSjvG/MkVAKIUQFzVGhj404ZNGwgGbnb/Db7uBTaHIk3VMr9tgvrdjkQ3pVhzc8a
         2pbQ==
X-Gm-Message-State: APjAAAXaQI84z2n7znhU2rtc+5NOqVKXS7s/RhY0uJcxljBUflNFyuEO
        DqaXXJGvFbCX3IxMY1/Ql8U=
X-Google-Smtp-Source: APXvYqwI87rBw21prAQWc3aQlXI/SkgwCmlXXckzupJF+S2UnGgINom35+U7m1xPHubNdhJSMZiNTw==
X-Received: by 2002:a17:902:3183:: with SMTP id x3mr48812428plb.170.1556321622113;
        Fri, 26 Apr 2019 16:33:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x6sm61383487pfb.171.2019.04.26.16.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 16:33:41 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:33:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, gwink@chromium.org
Subject: Re: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
Message-ID: <20190426233339.GA42369@dtor-ws>
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
 <20190425163846.51730-2-dmitry.torokhov@gmail.com>
 <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:38:29AM +0200, Benjamin Tissoires wrote:
> On Thu, Apr 25, 2019 at 6:38 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > HUTRR56 defined a new usage code on consumer page to cycle through
> > set of keyboard layouts, let's add this mapping.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I don't think this will collide with the HID tree, so IMO, you can
> take this through yours if you want.

OK, I will do that, thanks!

-- 
Dmitry
