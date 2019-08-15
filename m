Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A6BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B794620656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfHOTQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:16:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfHOTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:16:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so2153413wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjZVenIlbWTFCsZCQvXfFFUTE9mH2wesqHCaNp0R0N0=;
        b=Wb4cPXEadBqlavavo3iangmRC9gm/2HHW7FlPcI8EmFgdvmtH00xIY2oP3OWyWaC0f
         tFViQQIOg/TRgTBcBGHli6yABbtdngSMXmguyMbtv1dnf3TuQFHxqwglczkpULpoM9qy
         DvbmZbVAd+3+OUVc/o1pkR40/j48tTThPYovbOUaaV4FFkWPl149pOvHSiv2CAZiFoHF
         EDgjW3nVxjZFTaonVBR9my6lOrKvSP/4Z0i6XuXf9EhFrmaChxME/UHdtNwM2qVlZA0x
         V6op162CDqH0om5TE6e6AEQ5E9sNpdOA4EhTEmaOXFdBOAKzaxd01OC2AMknCKQPQix5
         QxPA==
X-Gm-Message-State: APjAAAV9gUoY0WJbeWLc8fKmA59cixmZuySA7uegZEuGYETV6NEB9ZEF
        eeWav/afcw8SqpCarucvtHK9+AVz8TY=
X-Google-Smtp-Source: APXvYqzi7t0wEtizC0/f+1uKMqcgyKv5dXa/DWoYTWFONEaSzPhCcEhcPXZVZ43uG3p8gQL92tg6vw==
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr4235232wmd.48.1565896589126;
        Thu, 15 Aug 2019 12:16:29 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 91sm10142768wrp.3.2019.08.15.12.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:16:28 -0700 (PDT)
Subject: Re: [PATCH 0/3] software node: Introduce software_node_find_by_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8dfd1251-7745-d5b4-473f-12706fc73c99@redhat.com>
Date:   Thu, 15 Aug 2019 21:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-08-19 13:28, Heikki Krogerus wrote:
> Hi,
> 
> This helper makes it much more easier to access "external" nodes.

This series looks good and I've also tested it and it works
as it should (the usb role-sw is still found and controlled
properly) on a device using the intel_cht_int33fe driver
for its TypeC connector:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
