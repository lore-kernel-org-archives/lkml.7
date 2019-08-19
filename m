Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E2C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B9920874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djIUAz1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfHSGrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:47:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33017 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:47:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so601179pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U24j4drPE5otk7nf5gewos8QdH/rOYJfvY6KgflN9k0=;
        b=djIUAz1ndxEIlY+kxK+HTygHu8sR9iy1wPvGqaJ1mtbb8X0DgRD9X2//23gMkBQUnD
         byvxccJJhxvV91/H0YrNZczq2d5loRKnk/dwv5tf21upV3w/560zShjzVcL+LPqGKvfg
         nPXTWn+R2stP9ZDzciiNwl+E5/5IBP+u95pLoMFrwqn0saB/vU4dzJQLDx3VeN1ec+IR
         CkmlmwsQAXNmoUlIfvojXprQjvt8S7lntpMpLVqXC3orRClFXTRgY6e259WWjqMd0KZq
         t7k16eclKQlQBpERAi5eS3xnOCiNLsT+RYYWVlqbEtPTKm/D33mPdgodYvg+ViLwCVGi
         1+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U24j4drPE5otk7nf5gewos8QdH/rOYJfvY6KgflN9k0=;
        b=j/ja0lOAw+2b/T81osvGU8QKzTKxQufxBds5PxlHFaQy9MXbOGrIMiDza6vvbF66tJ
         jUlMhfpg37fW0DmLTA0Zw8ar4N+Bb/2QTDcLm2AmmpUkLFn1vnvIKMIXDQrUWazlSwT6
         LOWC+y8P5LhSjz8PxGDtRlK0qpJVc4q6U0MMymw7RzLT8IUX30nwP//I6HKZ3B4hTiN+
         MQXhXpvQj9QmLZfpLVyineinbviCF8xzx72815Betdq4fTqIbCSO4P/jHVhpLbpDqTJy
         NWhD52qYprWZq8Nrt86L9Lj/LPGfkUz108MxutJMv9iVuH9r4maSnljDNpye38MI97Vh
         oQrw==
X-Gm-Message-State: APjAAAXl9NrkZZINSKKI9hZPDUlx1a2qizjm5undGvFKYDWyRM3W3aLk
        A3oKJU2OWufuigB8s2OQ1j8SGg==
X-Google-Smtp-Source: APXvYqyRm31hfZbfmLKyBsV9eWUiiBhiB0DVtxpye32kyhXYNAL+EDIedFCg3gtIe6UU3rEhkWhZjQ==
X-Received: by 2002:a63:c008:: with SMTP id h8mr19094494pgg.427.1566197258253;
        Sun, 18 Aug 2019 23:47:38 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id s24sm14118882pgm.3.2019.08.18.23.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:47:37 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:17:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 04/10] cpufreq: powerpc_cbe: Switch to QoS requests
 instead of cpufreq notifier
Message-ID: <20190819064735.da3np75ybf64wpbt@vireshk-i7>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
 <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
 <20190809023445.xn3mlv5qxjgz6bpp@vireshk-i7>
 <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
 <20190819022614.oy5qdozde2afibwu@vireshk-i7>
 <CAJZ5v0gupf6amEMG2NJfPr8rzT1o5ef1u+1NW5E_zgOMqd-qsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gupf6amEMG2NJfPr8rzT1o5ef1u+1NW5E_zgOMqd-qsg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-19, 08:42, Rafael J. Wysocki wrote:
> OK, thanks!
> 
> The series is on hold, though, because the acpi-cpufreq patch turned
> out to be problematic and I didn't have the time to have a deeper look
> at the problem last week.

And so was I wondering why it is present in bleeding-edge only :)

I don't think I am cc'd to any bug reports on that, can you please help me with
some information on it ?

-- 
viresh
