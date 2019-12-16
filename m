Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F96C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B7F206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Sz0azdPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLPQhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:37:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39174 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfLPQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:37:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id z3so3167127plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6aEadTXeV9eOfz7zCR3LM3ty396F0SeFOiA5X+VDTXA=;
        b=Sz0azdPmlMiOffCRFSAxCImt6KS6crQJErhXpFf2WTP84q3lvvEZhjHN9hjXVfY98N
         sAwk1GyMU9Q53owqMyMeN+MjH1wM+J+q0OC5JN/Q4jB/p3Sn+NJ0LtL8eQ3PdY9uzWGu
         nZOydGqkTSUoXU0GW3ou0sLymh6WXz7e3gGjJ72QIdWeu3nC4ny44JNpV6ZxolQb8xRW
         Iyfe/N0CDkp/f1EPBfFr/WQaMCfvq/N/gs/XtA0ThVq05cs5WBRt1RvlPHr9PWztYk7l
         AJivIjrLiZu41fZ3ClNoaEfDEF+L2Cb4g2V31htdW/1AeGGQiFMoKNQll82IGlyStVz8
         2Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6aEadTXeV9eOfz7zCR3LM3ty396F0SeFOiA5X+VDTXA=;
        b=c6NEaTfhSd7Tp0mC1OJEW4mRIyJ3WpMpiWcUYq88KLR0TyMnZLIp/9+SDUcHgNtaYn
         ruyAKeqZlqIn/aQASdNdW401JyroGv9EYx6AQF8eXgUxwtVxStVHE1NQKZLvtOe+0xxy
         BxsglMGTvfbmpBgoH7Wj3dH9IUEIiFdTmvf1kwQWdSWKeV+RmafVkfToGWXt4DgA9cKp
         9ifmVkbq8z7JdvFn36N7iQiGGlfEtNyC+Jtq7B1nrVEZahBWQ5XQK4PkUT8HOgm7dFqz
         D2C63GozyatH0IXEbnweBWwQuSC3/TMogYIJ7XDtaHnXqgcKwVlcvi25o0yChxk7crU9
         Up3w==
X-Gm-Message-State: APjAAAXnjSNKff6z6f2Z5r1eliyO+Zuu/TMrgqRf8q+xs/Lx7/baJDCw
        KFllnhSU1yQvq3qavSjLCTh7pQ==
X-Google-Smtp-Source: APXvYqyl2z2yM6D5pjBtyVe86j0BP2QA+T0oBROFf+RteV+8ztQzwuUB8iVsmrNCU3wkKwRiqZOmjw==
X-Received: by 2002:a17:90a:bc05:: with SMTP id w5mr18549291pjr.64.1576514227516;
        Mon, 16 Dec 2019 08:37:07 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i11sm19914780pjg.0.2019.12.16.08.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 08:37:06 -0800 (PST)
Subject: Re: [PATCH 33/58] serial/f81534: Don't check port->sysrq
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-34-dima@arista.com> <20191216121050.GD22665@localhost>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <8318fa54-91c5-7c7b-cc97-53dd34c617e2@arista.com>
Date:   Mon, 16 Dec 2019 16:36:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216121050.GD22665@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 12/16/19 12:10 PM, Johan Hovold wrote:
> On Fri, Dec 13, 2019 at 12:06:32AM +0000, Dmitry Safonov wrote:
>> -		if (port->port.console && port->sysrq) {
>> -			if (usb_serial_handle_sysrq_char(port, data[i]))
>> -				continue;
>> -		}
>> +		if (usb_serial_handle_sysrq_char(port, data[i]))
>> +			continue;
> 
> This is unrelated to the rest of the series.

Right, will drop it from v2.

> 
> Please break all usb-serial patches out of this series and submit them
> to me and the usb list for review.
Thanks,
          Dmitry
