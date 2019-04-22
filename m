Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48559C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350220643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LriKm8pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfDVW23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:28:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34994 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfDVW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:28:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so6459168plp.2;
        Mon, 22 Apr 2019 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l5AxmITSIPrmdVWT9ltbBGc4UrQcWGmU2dmUvvxRp1s=;
        b=LriKm8pB8ehN531+Iv6xtcWLvEjrblTDmO+CNRFLemQ9eUdQzS7cbVSxRUdw3O/RxX
         b/IWBHYX+17nTDB+Mg1MwZr/HL0uwTIVMMa9+Vv3fa5akNEFmkLSXyTU6UHITo3GBma4
         u2fSTjzR26eyVBJntnA069sHYGqLYBuWAh6XH1yIdEOldQKOCcIjL9sqCzENERNq5lb/
         a/VAal80oRXvv2NSAP99bEU7uvVi34dMNf8eDysNbuLp7AdoSvqN/SkbsoltbdVLJ8WJ
         vU8fTOhFB+kT4G9MW6K/xCAQ89CAFXqBZPTW8LLiVv/iTNQonwKQCn06nFc/nFjNb8IU
         OPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l5AxmITSIPrmdVWT9ltbBGc4UrQcWGmU2dmUvvxRp1s=;
        b=fAOija65uHZGrvyE/xXh1XIQBOtH5BA4LL9Uf0TOudwvdpQvTRAnuWmmFOy9nQQlmm
         o2EXuhSgHUnnaVep+NF+Pu/ZAkthVUqtPU1ABFimS7bKE3yyow3/HpF/jngqCuNhJWE/
         Y9zhSD1znoxCVvsKj2M4puEVC9BiZ+8g4NUSgAsWYGiojREliRW5a4qORKLS4FNeEB25
         0P5t8r1Fj+sVSg52B3kBPV+xhy1uSAbTMbJMS2R1qFfbryVUDWW1v43Hdd7WFLolbuZA
         x5LiszN/o357jhiMUWSAnZAXt5r6Uh/PzsTaRNptKcAAtcAVfH97FXJHbG472OE5nQ2+
         xunw==
X-Gm-Message-State: APjAAAVZ50Az2dpIkVXU4VNRB4Ilf64YKqCgRzsEx7OF696AbN15ky2X
        wiYzYTxpSukl/akqIYYEDX4=
X-Google-Smtp-Source: APXvYqzAk1lkaSPfLPtKoCiUGATWprtVGPXYcGaxLmKED5CVGWvN2Cj1kl60EKbIlBpwGK1hUuqbAA==
X-Received: by 2002:a17:902:3324:: with SMTP id a33mr22770566plc.186.1555972106937;
        Mon, 22 Apr 2019 15:28:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3sm25455837pfn.179.2019.04.22.15.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:28:25 -0700 (PDT)
Date:   Mon, 22 Apr 2019 15:28:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] docs: hwmon: convert three docs to ReST format
Message-ID: <20190422222824.GA16756@roeck-us.net>
References: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555954774.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555954774.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:39:37PM -0300, Mauro Carvalho Chehab wrote:
> Those three new drivers were missed on the initial conversion
> to ReST format. So:
> 
> - Rename them to .rst;
> - Add them to the hwmon index.rst index;
> - add some blank lines at the "Supported systems:" part, in
>   order to allow Sphinx to properly identify new lines,
>   suppressing warnings and avoid it to output some random
>   lines in bold;
> - When multiple authors are involved, change the authors
>   part to a list, in order to avoid adding blank lines.
> - adjust the table cells (one of the tables seemed to be
>   assuming that tab is 4 positions instead of 8) and add
>   the table markup.
> - be sure that the section markups have the same number of
>   characters as the section title.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
