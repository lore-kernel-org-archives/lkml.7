Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA673C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A04F24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IUAwBVG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFATh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:19:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42621 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 19:19:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id a10so5001566qko.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=X5BKMDzhk9He6AKioqZn9xv6gd84tSO5DFO6xwMevYw=;
        b=IUAwBVG9f6xINWXkadLp/j/jGbF/ANfoSF5zsqFLLy+AU1UlJCfRoRBOV7SJHs+dAv
         f8q6V0G7bNoJxnZHoA24ySqhT0OUWno5vkNaOv3uvp3sUnz8MBtb+gk5hlz/jN2RWAfV
         EITcumIBCswQfF99cv1YWBjwU334N2mUhl3o+WlxlN/839LS22tfvWElD1xQ3p5LAjkw
         DlPUe9Ujy9r1lECzPLYQ92cfwynapmsImU5ATMzbsQvKD2UxCSCe6hIDYxFdymymGb6r
         owoIhLdVxxQIlhAqVP7pS5nJ046IPuHfQbrXz/SW6b42gOKhqHg+xtqmyhlvchUJovkW
         WJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=X5BKMDzhk9He6AKioqZn9xv6gd84tSO5DFO6xwMevYw=;
        b=VlU1yDJiAXvQ7DdMbzzcDCki1XreA3sxFk/algkgm8FOYQFHKh+K9PbQ3X74JBKbKc
         aLxlF99xTb6eefu3zjiv9xeK2Rb2ZzIB/nQnJKbGgH49eRghcbhWFuYYk/MApDWri24J
         1XE2MOZa+msXzIZyhuuO/iOMhpAr7VXrjadkuSNnvWjQm7v7tmLRz8/w6v9cTWlizyez
         WL1WdZTgIaVJ/iUO6SF2cnNO+uePF6zK0KzvLyuCSWwAiXBzW5fT9HPZlH5K4HpHgxUV
         j8BilaZ8SuSNDXmBajF3iZEA5oaoPvnwRljsowAdPdGQ6O2BUfeXpf7r8vjUpdl0sCDt
         QdvQ==
X-Gm-Message-State: APjAAAVEf+KAIfe56E5JOkj0NCIvE/CI+nhAfE7vXYQoRftpwxXh4oaG
        TakYYNFzXgpKNH86ORjVQ2Z7Yw==
X-Google-Smtp-Source: APXvYqyKOaKqD4naAnIv6vb0dV+7aph7vWmbuMsUb65qWebhgIw/D0smIg8+d1WU3nRWNxhsfUckdQ==
X-Received: by 2002:a37:4b06:: with SMTP id y6mr4646884qka.14.1575591575819;
        Thu, 05 Dec 2019 16:19:35 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 62sm5327116qkk.102.2019.12.05.16.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 16:19:35 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 19:19:34 -0500
Message-Id: <D0A99204-A60F-428E-B77A-63DBCD7103F4@lca.pw>
References: <22b5bfde-45be-95bd-5c98-2ab13302c107@nvidia.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, fabecassis@nvidia.com,
        mhocko@suse.com, cl@linux.com, vbabka@suse.cz,
        mgorman@techsingularity.net, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <22b5bfde-45be-95bd-5c98-2ab13302c107@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 7:04 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> Felix's code is not random test code. It's code he wrote and he expected i=
t to work.

Sure, but could he show a bit detail if the kernel will start to behavior as=
 expected like what was written in the manpage to return ENOENT in this case=
, why is it not acceptable? i.e., why is it important to depend on the broke=
n behavior?=
