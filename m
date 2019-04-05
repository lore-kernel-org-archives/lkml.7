Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F71C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6199821738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbmo+D0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfDESbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:31:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44464 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfDESbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:31:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so3716181pfm.11;
        Fri, 05 Apr 2019 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HjnMMzzWXygt5SsXPN8EuocObqrtg87GcU82yAp8fU8=;
        b=Hbmo+D0OHAqWulwg6iTD3Tb79NcXxKWY3RUgSs9U4a9Dwxm53wmzRoHHqduLNf+3lT
         2TvExxqdsVifcwrcCAR+8dDkM0N2TBFOT/VCBHyMd88tQ85p19Y9JQWn0i3H/XwUxIF3
         d1XlR20fwTtYYOzDLf3+/IDRSzxydcXvHe0fSJvtsNp3CwMkKmG5GyW7Vp/IJgrTwHKW
         Tm4Sw8VlR71kqzejZmWpQfHSMy3TbexW/dN9E73bA3V/bCUsEoXOl/5kL8Leuv39ALq3
         TP1d+BJrYF9oDnhKf6QvzYaSoh+JK24Eqbbh+kPlBMLelfgdDUqkwip63b7mf0xBEFlw
         bo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjnMMzzWXygt5SsXPN8EuocObqrtg87GcU82yAp8fU8=;
        b=umwJgrBUviBfkh4dcFBOiVRtk3zfVchDJrs056fW4Brv7e/+hVpVqQ0XNwFu5DjbwR
         6yXb3aiWqEQygLU3HswgEGzW3ZB/ydWknGZhwKxT/dNRHet2bUBwlliQr4FZv8BFBTkv
         avGoun126otyMhEc/r5TP0VakcRh3ULtSGnT95Rfjc/u4ZCmd61WOgPVsySRnUS+bByQ
         jl6LyNYz0LT2H1WO3ljtzrJIPbaMzxyKzeje+49T12KXj2DCQuh+wSrknlKZKAmVbvwq
         vhkEdOWOPZpm3RycMOjrCEgF6I6xefoDciovLfY3vrAAWyHagtPOoztUn7aAqv7hKz/c
         n+eA==
X-Gm-Message-State: APjAAAX7G7k9Sgvj5ONVowsc6feasKFo2pPyv9ucEH7ZrcfIYjvlXFwA
        3OvlZcbR1qrLKIL9N/C+/uiU0E8u
X-Google-Smtp-Source: APXvYqxuTcxLMLaYy9EeKuFkst60rx/M0ak4s91szHdU+GwiYRN0u3R1VzhdHTN8Zd8Oi9Gt5kKvjA==
X-Received: by 2002:a62:4558:: with SMTP id s85mr14165908pfa.171.1554489090292;
        Fri, 05 Apr 2019 11:31:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b16sm31276003pfo.168.2019.04.05.11.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:31:29 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:31:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/187] 4.19.34-stable review
Message-ID: <20190405183128.GD11563@roeck-us.net>
References: <20190404084603.119654039@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:45:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.34 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:30 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.19.33-187-g4b338ef616b3:

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
