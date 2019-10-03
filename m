Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5465C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DAB20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjFfdS8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfJCPO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:14:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45988 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJCPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:14:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so2679289qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kXqhe9MS39gp9iJHADv7S5Hk2iunhpB1wPpQreZu69c=;
        b=IjFfdS8r3/G8O3ddsLBPDV2vlhrdy221gHJ97jkkYRUDY7cA3GESBee0NWk/WdHhia
         kMCJCtUV+5vIVb0PFheGiAT/HCNVt+mYo1tkHk6LvLSsJxq0U8uIVqTDNYOgO0elfInh
         k+wQHhCckljTMVxF9NSG/d1DpPV7b8pp868eibpn47R8emyRO4vpUOUudayeJ8ePt4Zy
         Y3B6OCb+98oWl19S34W6dzvYGaGGmI6NJ5AXyDfpmCIa8ZM5xZcWk0epYmxEs3pdA1yS
         eP64ImzDo7Y/rFQ95+sOdC1nzOmkJtE8opJymg6rd14enM1pXtFcQebF/yh3fkgC1XPR
         52Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXqhe9MS39gp9iJHADv7S5Hk2iunhpB1wPpQreZu69c=;
        b=lWBlPucarox52MAxDar1Jdzt+tnjSCmyrDeVGxU7omYiKKmxcRbDtZ+J0Bc0CgSGNe
         BZShV5KtsZfh5Wdfo85lQyYyZezRfNK7iCrRyTcxiOfs61BHYUvSSATyplQdLxmYpCgG
         aTGd62iOLqDe6WpS42zgAsF7sqVqHfGkluQFtVAJ2nfBiiQk0GpeGF1Qsa4kqvJN/PEk
         p3yheGXde3Ae0DgM9h3GLYnM9oYiu3NfBqWeK0bzd5adtnzbgaWn5abhjb6c9ihNZRhu
         e6EMU3DExhE5tT1JxvoLvtyLczSczmr7r8za3qjuHdCWHQND0WL2C7nhh+7EShBtGCvB
         vIVg==
X-Gm-Message-State: APjAAAUc5JNnqUth4mJyvYBdrlx2aVn03P5gU/mxX8TDo1icC2HT9b+M
        rMo00v4W45obY6wFU+i5hpyiQ8K5yzM=
X-Google-Smtp-Source: APXvYqwcTgy8QDPg9/016fXCEEE1PQvGMdLYuiY4uhh9lyY8WzHU8APjyQHe1WtkXon65QurnYSjoA==
X-Received: by 2002:a37:4c14:: with SMTP id z20mr5016501qka.296.1570115695403;
        Thu, 03 Oct 2019 08:14:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q126sm1559952qkf.47.2019.10.03.08.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 08:14:55 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 3 Oct 2019 11:14:53 -0400
To:     Greg Kroah-Hartman <grekh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 5.3.y stable branch has been bumped to 5.3.3?
Message-ID: <20191003151453.GB2887046@rani.riverdale.lan>
References: <20191003151237.GA2887046@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003151237.GA2887046@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:12:37AM -0400, Arvind Sankar wrote:
> Hi Greg, I'm seeing what looks like an extra commit [1] in the 5.3.y branch
> post the 5.3.2 tag, bumping version in the Makefile to 5.3.3.
> Historically the version bump has only happened once all the stable
> patches have been applied and the new version is getting tagged -- is
> this a mistake or intentional change in process to pre-bump the version?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.3.y&id=9c30694424ee15cc30a23f92a913d5322b9e5bd3
> 
> Thanks.

Err, sorry about the noise, just saw your note from Tuesday.
