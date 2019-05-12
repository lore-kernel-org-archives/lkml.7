Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB58FC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F15D21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j76JY+qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfELSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:30:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33894 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfELSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:30:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so5570795pgt.1;
        Sun, 12 May 2019 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VyXlbEm2zCgStRLO8CiIxUi3PJUNE4kOKymm809f4oo=;
        b=j76JY+qb0K7qxKCmyqMZyCQc/eA5ILFjxye1uw97XccgG8Eybm/iMtcKR9ULGr/KI7
         P56Vl9ixiAsx2Oq+o1ez7E+9a0cc7mULk1FEEolQuYiJaauNmtXhqVkfY3txJi917hqB
         67aQGBsj1qDoFyAlYfWwEesKGkRAF/5jZOyWJpyVtfpGKHrFgplv2vG3NogL+ksqoNdZ
         8r3t3Zu8XsOLW/RTraFkTNxNzwXI1oIFvC/Ta51YlP1xRDIguvYJqAblDuFIZIcSvDoo
         8oCXkNxwJ98671fTliyNRekt1Qm9LPjdmKQsDkZV7SOai/ns9dkQ9kIzNB6Me16dwlCy
         OVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VyXlbEm2zCgStRLO8CiIxUi3PJUNE4kOKymm809f4oo=;
        b=av8y7zio0J373/0ZfhgvmJBLnGnFEguDCkk8P8ojEHL8d483VejC9R8gZvhT2zB567
         1adHlEtwXhoOX0wguxhUqL3m6mUb8d4rdKHM70XupPNfKsVvIqkWR7tQc7/VG1DOTGit
         UoGHOpsVpKvMrJnGJaF+Wb2LRphGbf2suYVI/xRurgItZF00JMasE1EVqmlIEEbFvPZ6
         mHFZPHnTrw3YTzs7X8EB6zRJzsjdgPGacOsVj//s+Z37ECQw/VCX4y50zNXQbrYBW3gl
         vcSAqVhrPu2gwDWwQ53O7H9Dwobw8RsRNAMOVXE1rOpy5RkxriSfIlx7gRdmwIOcCffk
         8X0Q==
X-Gm-Message-State: APjAAAXwwWje58CsJdvEOFo8jnTEN9NiTd6iMTUDRzuL8a4QHeTUD1L/
        whSxQtg+xbGp29kgOHA/8f/tPccO
X-Google-Smtp-Source: APXvYqzvICx3Cs9BCmzOR6F5nidTErPTfJVJy5O2OlKTVhOlFHRZDxhu2WVhsOel6pUutf462XhbCQ==
X-Received: by 2002:a63:f703:: with SMTP id x3mr26200659pgh.394.1557685837213;
        Sun, 12 May 2019 11:30:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id k65sm17340214pfj.141.2019.05.12.11.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 11:30:36 -0700 (PDT)
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
Date:   Sun, 12 May 2019 21:29:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512090446.GN21483@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.05.2019 12:04, Mark Brown пишет:
> On Wed, May 08, 2019 at 04:27:42PM +0300, Dmitry Osipenko wrote:
> 
>> Constraints:
> 
>> 1) The max-spread voltage is 300mV.
> 
>> 2) CORE voltage must be higher than the CPU by at least N mV, where N
>> varies depending on the CPU voltage.
> 
> Those seem like they should be doable in generic code, though the fact
> that the constraint is variable makes it annoying to specify - otherwise
> it'd just be a minimum and maximum spread.  I'm not really coming up
> with any great ideas right now, it's getting into OPP type territory but
> it sounds like there's more flexibility for ramping the core voltage so
> you'd end up with silly numbers of OPPs.

The OPP shouldn't have to do anything in regards to the regulators
coupling. The whole idea of the regulators coupling is to make device
drivers to not churn with the coupling. The coupling in this case is
specific to SoC and not to a particular board.

I think the current approach with the customized regulators coupler is
the best solution for the time being. We may consider something more
generic if there will be other users with a similar coupling
requirements, otherwise it's quite difficult to judge what is "generic".
Do you agree?

>> 3) There is a constraint on the maximum CORE voltage depending on
>> hardware model/revision (cpu_speedo_id) where a higher voltages
>> apparently may cause physical damage, so it's better to hardcode the
>> limitation in the code rather than to rely on a board's device-tree
>> description. This constraint is quite vaguely defined in the downstream
>> kernel, I'm not really sure if it's solely about the hardware safety.
> 
> I'd expect this to be enforced by the cpufreq driver just not selecting
> higher voltages on affected parts.
> 

CPUFreq driver will only handle the CPU regulator and it won't know
anything about the CORE.

Anyway, please scratch the third constraint, I messed up it with the
other *minimum* CORE voltage constraint detail which makes the minimum
voltage to depend on the hardware version in addition to the CPU voltage.
