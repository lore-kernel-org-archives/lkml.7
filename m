Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ABECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617222166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gClEFeCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438238AbfJXIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:33:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35941 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJXIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:33:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so18404301lfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+75bXYmJLWTFE3320pYIpgc0DqJcYlwjBZB7EAmPS10=;
        b=gClEFeCU+g0DoMciGkXeW9Z7OGI79blTyZ9lLfcjrBKqg5p80UlmyeFFLuXc5KT5hH
         Q3wWVhydm7bwX2DiG3ftfR8cTTAs24mFH15R4Q4mAz2paRSJ//b3ENgS7RgbKaBPM+Ji
         khtnY1Yt0+YLyd0ZBxlay/rj9Am64z/A1bYGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+75bXYmJLWTFE3320pYIpgc0DqJcYlwjBZB7EAmPS10=;
        b=Zl3kuPxqpC7v+ekDkY5LYj3ChGDZ75XnujbqSzqcD6gOa7FN43pQ69oOawQ6bnT6S4
         OPwemo/N6WQJhsW1mtjvX7qXi6+2qxmr8rq/xLCTp+O9BIUevgkK0OE8N6TJimB/qNy5
         jTYPX7X3Lx4uT1h2Aoz89sznudp2zR13IPJFinO41LN+r5kaxvMkXaNnoR13wV15Uziy
         T649tS44qTnxrXzLGZNdNa2yaAedlxjtXCPw1EvleDYRFteZNyQ9xU3ISPGoEC+LhDTA
         WOmRTJR+lUfFQPRncFqusdgXlP6Eaa/y+NDOfsGyuvZV/ZzndPgemTexttt3RPqaI4q3
         ZQmg==
X-Gm-Message-State: APjAAAVsp0eJ1VfeIXDglLtv6nHWYJWb5PldtmSqCqwa4G+scmKlZdKg
        uBpLm2g0ekPz2XPKIdeHB4ToSiJnPstTv+Ds
X-Google-Smtp-Source: APXvYqzGW/Z8ZcO24MLlZ7Q5TGMTH80egPpH3CSH8TEMirFgblCVOGKAPMvCu448esyNvmcxQil8nA==
X-Received: by 2002:ac2:5f0a:: with SMTP id 10mr1989441lfq.57.1571905977834;
        Thu, 24 Oct 2019 01:32:57 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p18sm12995854lfh.24.2019.10.24.01.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 01:32:57 -0700 (PDT)
Subject: Re: [PATCH 4/7] soc: fsl: qe: replace spin_event_timeout by
 readx_poll_timeout_atomic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191018125234.21825-5-linux@rasmusvillemoes.dk>
 <20191018160852.GA13036@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a11aaeaa-7075-4ad0-aa26-d8d7eafa72f5@rasmusvillemoes.dk>
Date:   Thu, 24 Oct 2019 10:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018160852.GA13036@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 18.08, Christoph Hellwig wrote:
> On Fri, Oct 18, 2019 at 02:52:31PM +0200, Rasmus Villemoes wrote:
>>  	/* wait for the QE_CR_FLG to clear */
>> -	ret = spin_event_timeout((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
>> -				 100, 0);
>> -	/* On timeout (e.g. failure), the expression will be false (ret == 0),
>> -	   otherwise it will be true (ret == 1). */
>> +	ret = readx_poll_timeout_atomic(ioread32be, &qe_immr->cp.cecr, val, (val & QE_CR_FLG) == 0,
> 
> This creates an overly long line.

Yeah, readx_poll_timeout_atomic is a mouthful, and then one also has to
put in the name of the accessor... I'll wrap it when I respin the
series, thanks.

> Btw, given how few users of spin_event_timeout we have it might be good
> idea to just kill it entirely.

Maybe. That's for the ppc folks to comment on; the iopoll.h helpers are
not completely equivalent (because obviously they don't read tbl
directly). Maybe the generic versions should be taught
spin_begin/spin_end/spin_cpu_relax so at least that part would be
drop-in replacement.

Rasmus


