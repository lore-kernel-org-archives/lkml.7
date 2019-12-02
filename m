Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389BBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B16420674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayWr/e+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLBNNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:13:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35167 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLBNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:13:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id o9so9955952ote.2;
        Mon, 02 Dec 2019 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WpIVdJ8zzeydWnGV0Hm0bnq5TGbHkB7RgM4W8WL7sQM=;
        b=ayWr/e+ojhqdyu94ajPFzL4M/3r8yrPBFpdu7nuiYbIwFygf5EZ9TGON0Us19wyU+g
         V68zxsz72/NemBDm2k+BI3fe74hktkIKR7RGb8FhuVdIZtsUYAw7o9e2HbuMfE8yCxLP
         88ucrHc5Me/bP5KjJwif2SovclkPZ5qqjqzxbAKDaCDcYj4vc/U/a0m9OR+cl8q3Fj56
         D5Y2983Lbri5rCyCKWUukztlOgyQ6Wt0kUxIREWGMUD5hqaqiOJiaUzdbkyr9k2SzZN+
         7Cud5lM13oPBVaDrrwFk6+S1C0Vv+gUzOBPptDT+WNZ7Qvzqf9Rl1ulx7/HUzxlCuB8s
         K94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpIVdJ8zzeydWnGV0Hm0bnq5TGbHkB7RgM4W8WL7sQM=;
        b=NbqHeU/K8tC8HmYZCYNnLengwlcYPENgkF6AJWa8CvQ9I3me1qbP5yuEvZXzUnPGeq
         tQfTXZbu7/DN/DxqwbE7YcyifuixpRwz7eRLbJQyqZe+vQETzQ8Z7OrJkCaXxZlllPIk
         UARhEo30qK29v01gYQffeSMKpbl+6G9GNjNI7Li1UlTTWOXsvGXezMFzVVwH4HTp0M/N
         A6ayIwLs18NoevXW4HtoXvEtaPdVAS+wMmko0vI10585MPhADVn3ft5ORiP3ZaKJhsac
         T2oVNnPgtmHbnj/gu9PBYjSAPSV1WSxGDJUy5xxGwl+cxLNsMK3WqXX3AVr7wA6zfstD
         n5sQ==
X-Gm-Message-State: APjAAAVUaI0FOMK2o9gIcnSwQTmXFPOiVD5XmLQ3pUHlp8dwgKfpIQ5j
        Gvf4F0Uw0qrfqPe0oOHkvxQ=
X-Google-Smtp-Source: APXvYqy4jx57qvDjpsvRN6iwGNeUOPmVPh3Uq+t3tmkFnPEJ9SiuOml5GNtzXGDCfgq9FhDaTZxeHg==
X-Received: by 2002:a9d:18b:: with SMTP id e11mr19617070ote.305.1575292388688;
        Mon, 02 Dec 2019 05:13:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y16sm7700673otq.60.2019.12.02.05.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 05:13:07 -0800 (PST)
Date:   Mon, 2 Dec 2019 05:13:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 19/23] y2038: use compat_{get,set}_itimer on alpha
Message-ID: <20191202131306.GA6633@roeck-us.net>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-10-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:12:18PM +0100, Arnd Bergmann wrote:
> The itimer handling for the old alpha osf_setitimer/osf_getitimer
> system calls is identical to the compat version of getitimer/setitimer,
> so just use those directly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

alpha:allnoconfig, alpha:tinyconfig:

alpha-linux-ld: arch/alpha/kernel/systbls.o: in function `sys_call_table':
(.data+0x298): undefined reference to `compat_sys_setitimer'
alpha-linux-ld: (.data+0x2b0): undefined reference to `compat_sys_getitimer'

Guenter
