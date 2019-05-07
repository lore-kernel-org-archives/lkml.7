Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899BFC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577CD206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAWAzdv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfEGSjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:39:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42401 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfEGSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:39:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so8599858pln.9;
        Tue, 07 May 2019 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9WgvVFq8VW5gFpALMMn6cVhuFDicBgmBQtiv0EbYdQ=;
        b=iAWAzdv5dTrGqh7NRwwupMhEx72PS43ue9F7aWmO5xvdv5B9scfqFcJhG1fLZ3pxZ/
         +/clC5bSK7sZ1qtG8XSwjiRoVc13wOKNE7p6h4g/xy9eHOO2A91e3EYhgQY6wj2+7R4v
         z+HyI4FjL1fDzXJsSziXAKzx4ApYQVSkASQAuccjKcXJjNc+wTwjqMkPg6nAv7jCN2m7
         +Gdj3+s/WPfR3J6p88eiEWTeqeycqB55zcFIZAYE8UGMuz7s4FXAidoJa7U9yPtTr7iK
         kM2OeYc0FA2QnC6juRY4aKAjEr3fK/F5l0wJmbhnmrFqrjkgjdhSuTNOT9xkd6e8+9a4
         qpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9WgvVFq8VW5gFpALMMn6cVhuFDicBgmBQtiv0EbYdQ=;
        b=XlGgLUuvNVO8gRosje2IJv/IBjIQFRpuxaIpb6K4VYesgjjcBL9CpIum15T1EDxrws
         cfS+jpT3Hn4McLWhUXfpU7jOgTcSwJxFw14bb2HR2XETZ+YGoy8iJc2908cLlurdB938
         6poCi+oolYF7oNMcg8qylTiP69ytg98acsBa/2UmLOOHRDCVBbxEYP9jpxc+tcaf8Tu0
         U8igue+9vFotEJlk/k5b3/wqmBdc3N/K5VvZhXoW1hbZT7TPhbTL1Z7IKOhuIrem8GiM
         aY98UO+/RGAZOmMxip9O1uiI1EAsKjOz+67P+nVy7+M7+Q0DDoI+OBXtc7n6TQu64vAd
         CLbw==
X-Gm-Message-State: APjAAAUhy3+v4qavB6VwchQjg6pLykgFnBJbpiKDRmuFQ4wv15JVyPuj
        JrzSZjyVdhkvKDUAqCFyzNA=
X-Google-Smtp-Source: APXvYqznBA6bruZZ/eTitL7tftEbjGkvUwGP7nvnAaP2V5NzwdhdFUhOdVK+QqqM3jCjZFVZlf083w==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr33814977pld.284.1557254340664;
        Tue, 07 May 2019 11:39:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm17985188pfn.113.2019.05.07.11.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:39:00 -0700 (PDT)
Date:   Tue, 7 May 2019 11:38:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/75] 4.14.117-stable review
Message-ID: <20190507183859.GB30225@roeck-us.net>
References: <20190506143053.287515952@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:32:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.117 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 08 May 2019 02:29:19 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter
