Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C475C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6BA2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsBPAh5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfDBTEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:04:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40377 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfDBTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:04:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so3748640plr.7;
        Tue, 02 Apr 2019 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJe868SU0Q5QQl2qOCSvdfUKK2UwcmA1GJa3Yry8b7k=;
        b=IsBPAh5M+zwBiIfu0R1Qh58ifnqI7hzrLkcukNvQxD1YQPzUx3BfuK3vR0LzN/JkzE
         f0KyV5LhiCJoNmKJGma4q/OYJ0vwML8aQ4SvD55LMMnPpEV5829GDmsGyIpOEwp0DbgY
         qpqW5QMUZ1bs70hLnlVP/eaFacTxpTQlxEVQdtkKeV4+yyVfJJ4xOuBcu8XS8B/5Dy+s
         +PI0wLCzrruW9kNLIXoDvVJWS+uBXCFhH8voUg1z78QgISeZfBxIYX8XeiOMF/cPF/5p
         MKjYrpHZcHSIdf+wET0W1iWui53SQ1uHu+sTPKEIoStK+ug4PW+1aqZEELfw1/FAUWm/
         9sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJe868SU0Q5QQl2qOCSvdfUKK2UwcmA1GJa3Yry8b7k=;
        b=uKJSyO7bk+mYkLPMMDDLuIS+Fuxl5NiycW+9ofkUMTddhi9aD9fhIX9rqAiboJz6kR
         +bkSi29V91tMyScSXPMg88+8svoZaBjDzI3zB8I1WS6D2YVdKBHH3UfnRSNPhk64WQGw
         iWCfRkLmT/m+gooQS5eqI2qwXGCWPnJQ5AGVMFQiuXGREWwbF1Vi0V2h6oQ0oserhLOl
         ijS/tJKrlM1QGufXHWyJ4jGSwSoK3ROzPeD5AAuD9DXVW4wmIWONkXDZPNu6Zg8B3ZWo
         BTTlX3iqc1MYR3pXbAOuLr5Yjosl+DdW8U8CPvlSmqHxynbNuilxtTdbkPb/4wDrw+kq
         RY6w==
X-Gm-Message-State: APjAAAW7fTD0yES1Ouja6U7Q2Zi8tWHYXlCBv6cMXnHqKlywQ+SqDvh7
        0yiykHN1z4Wr++oc0mV9C0c=
X-Google-Smtp-Source: APXvYqy0MYugUBrmDxYTyp7GIGpwpAthb47bI737KgZ85lgYAJ/NbsuietgRfZUTARJOIJDL3Kdl9A==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr28851602plk.290.1554231874299;
        Tue, 02 Apr 2019 12:04:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm16529013pfp.70.2019.04.02.12.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:04:33 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:04:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/131] 4.4.178-stable review
Message-ID: <20190402190432.GB14232@roeck-us.net>
References: <20190401170051.645954551@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:01:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.178 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:39 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 292 pass: 292 fail: 0

Guenter
