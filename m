Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DDF2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfHOR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:26:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfHOR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:26:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so2903105wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4+EC3K/OraoQekA4qFzE8BLaZwE6owYXq+qixqnFME=;
        b=UpZLOlyI6rs6qg+pR9X/u0ZzAgfyL3DXctCEkzW5HEHKuEzDPBgMRc6Q8oTGRLeJyp
         GkglK39Rmu1FX8aHxh05S7CUa7uU0RHFSKozEBky5ZEvTELEaJ5FJHHw5ySivbevXfxc
         zUHOSIy1yfxSo0uzHxC+YJDBoaDsxc+vz1LQocbUVXdgTQrvlnNFWsRWViVQj6Vl44Ae
         gOGXw8Ce9Y+9Ad8jIoQTBHpBTd9S735tHk4fFJIlivhbYrHkIUYAJsRGDGetTZzKDZx3
         c92AHraOt80dV0ugSocOEo/waWCJOGvuD37DGQOa16EJYEybvi82icv0J/16VejXBWXe
         AKbg==
X-Gm-Message-State: APjAAAVwl4vwicNjN9XkeaSjtqbvrJNNJXi3LpylUt6gUsws+udu65yT
        yQFop/Mam9RLDhU0bC5ah+LhvDukEow=
X-Google-Smtp-Source: APXvYqyYPY95uK6vTb/hFt+RKFB9Pmf6Bnhkb5VvVPjrB+VctenX0bTjjplB0OYB7X8RzuIEBe/oLQ==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr6614069wre.169.1565890003935;
        Thu, 15 Aug 2019 10:26:43 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o14sm3642773wrg.64.2019.08.15.10.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:26:43 -0700 (PDT)
Subject: Re: [PATCH 0/3] usb: typec: fusb302: Small changes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4a97653f-9222-9cbd-1944-e5192775bcb1@redhat.com>
Date:   Thu, 15 Aug 2019 19:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-08-19 15:24, Heikki Krogerus wrote:
> Hi,
> 
> This series removes the deprecated fusb302 specific properties, and
> stops using struct tcpc_config in the driver.
> 
> thanks,
> 
> Heikki Krogerus (3):
>    usb: typec: fusb302: Remove unused properties
>    dt-bindings: usb: fusb302: Remove deprecated properties
>    usb: typec: fusb302: Always provide fwnode for the port

I know this series is already in usb-testing, still I thought
it would be a good idea to test it on my CHT hw with a fusb302
TypeC controller. So I've just completed testing this and it
works as advertised:

So FWIW:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

