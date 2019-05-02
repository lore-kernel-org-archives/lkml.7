Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5D6C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A820578
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faB2OjTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEBU5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:57:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46987 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:57:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so3442878ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IM6gRPP9vGYAtrlAGvrZ2f9cRbqq+2XFYVZx5ounwgo=;
        b=faB2OjTUqLUYYuLoMp7WpkRaNTZEgletqliLc0MZ4+/osrjMIZcLCcfxLJ8eZrgc+F
         pPhuKsTJfgrf8obzFfOQ9DBQswWwpy3rOilB/ZqgtZ6P7FAtpvwKlPGCcsEZiNfQYsGP
         sFT/rV14J7xZDOI0G93FUODYhEA2zSR6VoQx36G9kvuAdRt0XaRmiCNreHLM2HzGfI4T
         3e9FrHEO6d1DITNJXERhocTux647SkuM3zhlBM7n5lgxHkHVHWyrFTMyBy0e5dwPzHs4
         TLM3Hd9ZAhHg8Dpoasypghsr0LCvxn8F7uUpb05vRxf2ntvETOQUwmk7zJWZN6NrlsUv
         qr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IM6gRPP9vGYAtrlAGvrZ2f9cRbqq+2XFYVZx5ounwgo=;
        b=fqs68XeeXl0KvtQeFwdUqq5FrxZjxxNDmZBQsnPt+na4VI5PxXYAu/KaE/kOmRDh2w
         SzE5EvjnQ/c9fJBCV548ZpBk5oda2RdFgHPXpBhul/CsP+lACNJAF4MsZAW3ZnzzurAl
         TWX1XD1LRyMqcTZb9nYsJLqI5KJzyGw/oxlleZ67XfDej1b8SioXSEK8cImiidT7ucQM
         EvpnEx/6au4o58mRixHtRL7Bkqjmss4R/aEJFZEv95VgmqG44RMt62EwCTzMU55qjkHx
         xxqZrkZpV0sPeAYnoZSQswF4nYucSLuiv/0Tz5JOW+kfFW3I9rLppjvFW+PHfg5eF+dN
         MSyg==
X-Gm-Message-State: APjAAAUBHBGtOJmjNo3sxf4sKRbq376zGkLQNxzGg3gl3JHm7M3YUBJr
        sOXk/WEDEs71m5vaToim9GY=
X-Google-Smtp-Source: APXvYqzpsjoV1s1hnIKwSS9e7RCryB3e50vVNZv0WlsQ5f+zrRhCvMjengCjsMlTvvMImTqrwmPAng==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr3098436ljg.145.1556830631022;
        Thu, 02 May 2019 13:57:11 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z16sm40915lfi.9.2019.05.02.13.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:57:09 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4AE3B4603CA; Thu,  2 May 2019 23:57:09 +0300 (MSK)
Date:   Thu, 2 May 2019 23:57:09 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: Re: [PATCH v3 1/2] prctl_set_mm: Refactor checks from
 validate_prctl_map
Message-ID: <20190502205709.GD2488@uranus.lan>
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
 <20190502125203.24014-1-mkoutny@suse.com>
 <20190502125203.24014-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502125203.24014-2-mkoutny@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 02:52:02PM +0200, Michal Koutný wrote:
> Despite comment of validate_prctl_map claims there are no capability
> checks, it is not completely true since commit 4d28df6152aa ("prctl:
> Allow local CAP_SYS_ADMIN changing exe_file"). Extract the check out of
> the function and make the function perform purely arithmetic checks.
> 
> This patch should not change any behavior, it is mere refactoring for
> following patch.
> 
> v1, v2: ---
> v3: Remove unused mm variable from validate_prctl_map_addr
> 
> CC: Kirill Tkhai <ktkhai@virtuozzo.com>
> CC: Cyrill Gorcunov <gorcunov@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
