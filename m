Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD1C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEFE21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBtS+Uj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGDJsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:48:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38763 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfGDJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:48:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so2701816pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UH5tf6umNqbdP3ijV0rfOnwSncCADAiCEkGZp99PCQ=;
        b=GBtS+Uj8Hlp0uUy+wKTCbJgr2FSZRMznVubXFu1V8nEptW7531bQA/wGb8lvEi9OH0
         Pn+xCtWBAtS0Ex73eTusZH/Zc/HjWpDeqoZtqnBW1CaZ2JYRNrnZW7KIJ54F1I8ia3H9
         eYcGDweTwkAu3HORZ5om6jY1qlBZjBj2h9yyPHWRkSn7rbQSH3RUTgs2mTezjhMMvVjh
         ZbvENwM8/O3fxJkPs4HXRdHmt+TafkVThlZNRAMZWcjp0n8a44QN2w/SqW/B/IGz+BmU
         yeR6ToQrIOowdxRMM2lNeGsFM8+CAw907XrhbIpeF4JAmvzDDM2ytzc2oie86ZdRCMIu
         qplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UH5tf6umNqbdP3ijV0rfOnwSncCADAiCEkGZp99PCQ=;
        b=DrQyGahi/VUQpuG8BWftTuBqUVBlGod9B5wTIZkjGdEso52botnCFn+Hpc1ViQrQtL
         i60cs2udrmamjBuVTDskyNRVQk+qko5hEZMuOiD5SeXj0qIHzmadHUHIbPhztu4ysHF1
         H+tofm+vLRAW/tff/Ip+4DRIprgpHyKwqrQ9dawdLh6iW0eOdnp1kl3u+thh3p54fVFZ
         nTsZN66UthG0ptzQQxc667oW9Y0FpDIfyJJ9PjnlDxlMo7OStHoxxjCFNlBESup8bkVr
         RSdq+JKxoQVEZxoHvQYWK1W2rM6yj1MNDp0KmSBzFIrpT7bvl8E0jznfR3aoNWIaZTYi
         EyaQ==
X-Gm-Message-State: APjAAAWfghpmZIx/D5bktWmd/E4lUG7HvGNEYAdfKz3lq4+YIu/yfCRi
        Jdu7nfEMIw0xA0TeoR0pzKhgWGzJQEc=
X-Google-Smtp-Source: APXvYqxFAAuQJcoa7vbQx68PaSBO5/fAqpVUsa5FLCOaDp29oElUH+Z7Fp975zsUXBWgRrcfoBh7Hw==
X-Received: by 2002:a17:90a:22aa:: with SMTP id s39mr18578430pjc.39.1562233717450;
        Thu, 04 Jul 2019 02:48:37 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id b1sm5188127pfi.91.2019.07.04.02.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:48:36 -0700 (PDT)
Date:   Thu, 4 Jul 2019 15:18:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Message-ID: <20190704094834.xbfjvdmly6maw75b@vireshk-i7>
References: <20190704194114.086d6a17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704194114.086d6a17@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-19, 19:41, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> In file included from kernel/power/qos.c:33:
> include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
> include/linux/pm_qos.h:205:9: error: expected '(' before 'type'
>   switch type {
>          ^~~~
>          (
> include/linux/pm_qos.h:205:9: warning: statement with no effect [-Wunused-value]
>   switch type {
>          ^~~~
> include/linux/pm_qos.h:216:1: warning: no return statement in function returning non-void [-Wreturn-type]
>  }
>  ^
> include/linux/pm_qos.h: At top level:
> include/linux/pm_qos.h:231:4: error: expected identifier or '(' before '{' token
>     { return 0; }
>     ^
> In file included from kernel/power/qos.c:33:
> include/linux/pm_qos.h:228:19: warning: 'dev_pm_qos_add_notifier' declared 'static' but never defined [-Wunused-function]
>  static inline int dev_pm_qos_add_notifier(struct device *dev,
>                    ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commits
> 
>   024a47a2732d ("PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()")
>   57fa6137402b ("PM / QOS: Pass request type to dev_pm_qos_read_value()")

Yeah, I have already sent the replacement patchset to Rafael.

-- 
viresh
