Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBA1C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C782120879
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9wxGFxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEHBrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:47:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHBrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:47:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so7917372pgi.6;
        Tue, 07 May 2019 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUKXTU23cy7eYBDs7cqVtk5qVyNyTWpbctBN9H6Jywc=;
        b=d9wxGFxfNkHkqGhmyH+8VMRaDv61gvP+Y+UQIUCJjqyIdCWYoyLSDBbzdHtmDqdx5r
         266FwvxIW3UNlwbuG9RiLTmHhsdrbMRC7fw8uo70PgstzvbdqTNwuMwa+MbD7yBEzdTy
         yvp5YeDm5q4Lkt5sut5GwgqiO73Iz7nClM6ThYBqD7eljKJpjgu4tCpdC1DNdJYavk1J
         1X1/8C7CJ4MYzO1ikAbTg3GXy5jdE4H4oXSXKX0ScKVpt/VgeWRx9l3ihRfJz7CwULIO
         qwKa1pGjvFXoKO3Yukp1959jLOUxzsotKi12UHubm8fzRwPOS+MMouK6bbxY01tQYyN8
         oTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUKXTU23cy7eYBDs7cqVtk5qVyNyTWpbctBN9H6Jywc=;
        b=NWCIDrJkdx1QIYdjU7WcNEKWy0UN8lyybOZH4xXvjhatrkpI+2iajk0ycWNh6Ds/w0
         /sct0WTq8YEWb57hYiFMB7SQfO27ECU4S7Z5JSLyuxTYuBwVhta3rYab2g4LPE0iNZP6
         D+v+oWHr9BCWexd4D/goWe9h990LqIXjXe+I3O6yfo+mGC3fusXDAV3q7Up2UpE2VG/i
         8+feSzEJnE09/ZLkEMnAfelo0wIDbX3DoX26JNfjTl3Pj2exwU7o+v6ymoti0WSfmJ4q
         Xr/Yg/oKG6uX0m+oHy9S7tgHEMwIGw/nliWnh/AuD7fUSID3ZLtYoq0nErUNFz+wy8NC
         WFuA==
X-Gm-Message-State: APjAAAU8b1piBX7iAlJRKMMlnzNx18wSGl2ESnYiLVJLu+YLTp8hgzd+
        hhWT1MkX6Egz/E8+6ZWuNRu69th1
X-Google-Smtp-Source: APXvYqwp5MCmikCBBBf4RJoK06gQX3cliAKSJDSVEwSqVn9CYbpMM01BQdwEP/weyMZBY7rMe5zYuQ==
X-Received: by 2002:a63:188:: with SMTP id 130mr43879222pgb.391.1557280066346;
        Tue, 07 May 2019 18:47:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c189sm22649570pfg.46.2019.05.07.18.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 18:47:45 -0700 (PDT)
Subject: Re: [PATCH 0/1] usb: typec: tcpci: read the VBUS_VOLTAGE register
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508004027.16558-1-angus@akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <74d20a42-b6cf-48d3-7777-a44e500b0eed@roeck-us.net>
Date:   Tue, 7 May 2019 18:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508004027.16558-1-angus@akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 5:40 PM, Angus Ainslie (Purism) wrote:
> I don't have a setup that I can test this code right now.
> 
> I did test the tcpci_get_vbus_voltage and on my setup it is always 0.
> 

Odd. PTN5110 is supposed to support it, though the datasheet is a bit vague about it.
It may be disabled. Did you check the status of POWER_CONTROL.VBUS_VOLTAGEMonitor ?

> I don't currently have setup that I can adjust the vbus voltage to
> trigger the fault.
> 
> Angus Ainslie (Purism) (1):
>    usb: typec: tcpci: add functions to read the VBUS voltage
> 
>   drivers/usb/typec/tcpm/tcpci.c | 35 ++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
In general, an introductory patch is only useful if there is more than one patch.

Thanks,
Guenter

