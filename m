Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F7DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3CD217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CEH/2rsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1MtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:49:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41457 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfH1MtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:49:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so2048361lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zlkz8KUfDT8cC4jOhmIeSJINsnWdWSyOo+2Oixz/yYs=;
        b=CEH/2rsPg2RAJzBYTHoa+XO5U2t7zjT6RLrxTXq1QnhwFU+qH7obrd3ZUvIGEJTKh9
         jACanixwWe4ptM6SADDhk04KKtwebYbPeXduxEKbP/CxbjYK1beusXiHESDfbZj/ioT2
         8GxAB6JIyk3PzqIhR/zXF51yfSVgc48MEJi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zlkz8KUfDT8cC4jOhmIeSJINsnWdWSyOo+2Oixz/yYs=;
        b=EM1lb5by5n3X5NuYKfOdZNhKOSAUgyFeeQvR2zAvGRFyOOC/vpWfnblfoH56v7T0Ba
         PeRmwKIAK93KO3AZ42CQfU9wb8Psz8feQf/HGqE65GKPluVpP61lxpnc2u9VfHiuvyBz
         L3FveESWYL0ew9C8sSy0BGBwBCd1idz3KWhIdQRWLcozvocvOqiThqaR/AeHAhAx2m1G
         /NcNZr5jyQ7QAC9WXCe/68oahRBItODm5aw+zi4QssGy/ffUt5wULiTceRzz96M2cXv/
         dinCKNNjD4BSwr3D+YBdv/dXETi/0WeGtdI3qBTzw8ECFUicEnqD+ZNdwZ0mMIEgjTln
         qBUw==
X-Gm-Message-State: APjAAAWqjiX5g/EW/tJZoCk/Y2scxqlB18JeeGaXVpNFZ9xJaQ7V/Y3S
        q0M99I9nYI1dDtLThZR4FlBw3rUAVlmGCYwR
X-Google-Smtp-Source: APXvYqyuyR7dqvFwYw4L2nqcfsgayKXert43eSrWPgU+L10hsDn9DiY2Z/FGPBUwry5rRf6lR4ufwQ==
X-Received: by 2002:a19:6d02:: with SMTP id i2mr2502485lfc.191.1566996557855;
        Wed, 28 Aug 2019 05:49:17 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b30sm814534lfq.59.2019.08.28.05.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 05:49:17 -0700 (PDT)
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Steven Rostedt <rostedt@goodmis.org>, Enrico@kleine-koenig.org,
        Weigelt@kleine-koenig.org,
        Andrew Morton <akpm@linux-foundation.org>,
        metux IT consult <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz> <87o9097bff.fsf@intel.com>
 <20190828120246.GA31416@jagdpanzerIV>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <087e8e18-8044-27ef-b0bd-8a1093f53b32@rasmusvillemoes.dk>
Date:   Wed, 28 Aug 2019 14:49:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828120246.GA31416@jagdpanzerIV>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 14.02, Sergey Senozhatsky wrote:
> On (08/28/19 14:54), Jani Nikula wrote:
> [..]
>>> I personally think that this feature is not worth the code, data,
>>> and bikeshedding.
>>
>> The obvious alternative, I think already mentioned, is to just add
>> strerror() or similar as a function. I doubt there'd be much opposition
>> to that. Folks could use %s and strerr(ret). And a follow-up could add
>> the special format specifier if needed.
> 
> Yeah, I'd say that strerror() would be a better alternative
> to vsprintf() specifier. (if we decide to add such functionality).

Please no. The .text footprint of the changes at the call sites to do
pr_err("...%s...", errcode(err)) instead of the current
pr_err("...%d...", err) would very soon dwarf whatever is necessary to
implement %pE or %dE. Also that would prevent any kind of graceful
fallback in case err doesn't have a known value - errcode() would have
to return some fixed "huh, unknown error number" string, so we'd lose
the actual number.

Rasmus
