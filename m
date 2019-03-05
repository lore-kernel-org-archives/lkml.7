Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D720684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551800562;
	bh=DNh4vFwAg9Rnqfhm9KRkb2bi+BjUCX9cfBwWJ1wAuyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yGbXGobwLbyrtIacSblLB2mF3oF7cv1lnwqT2K5OycmQMXuMbMB3TZUAPUhsenrax
	 xSteQev3mNX6nTQITl8DX2jMRB+ohXqBE++3gDkwSpOf922+c5tMQj7tsDeyZ4CRjt
	 v8i0MpyrvwcpzJIEqy+7aSs6Sp7kJEd2mdpe6IdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfCEPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:42:41 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45367 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfCEPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:42:41 -0500
Received: by mail-yw1-f66.google.com with SMTP id r188so7264941ywb.12;
        Tue, 05 Mar 2019 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDZBdwaChAn3RB4d4hTLVwKEXk+hZzC42CiJSaOc/m4=;
        b=VLKuPs0pH66G9o/zzWqDne/ydkzGw4Y4U2C8XPRudhsFYKkuwLTMmUPxJrgMoeWEpr
         5JUgb+nAlHyLiVeCOvtvIoo5f1ewVnEIBvZb7RtriNmDjQA6qs77+n4nH7tez9CwvwoY
         Ngt01nMu48VrqEF5KWIaE6n6H2j+Nqrvq7OecBsRqeKoJlL9TYL7K73zTnu2CehsZQmU
         r4zN6+A+XAHWMo+jmedArLy1S3m5tWSk2pi//kNWvP9qyS8FXmzX9Bq96ezJROFjpUgd
         GtIS6HeA2stG6E0ObNVfB/1eHqPgV7eZoaw3XA4tECnCDdd1LNa7Ps0+/iRYUq1FZSlV
         muNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDZBdwaChAn3RB4d4hTLVwKEXk+hZzC42CiJSaOc/m4=;
        b=UvAXoY9LEraeOjABG0gK5fgWS53lVzhntCQErd78Qr/qz4ikB9b+Zz2sRF2RO5BoiB
         KMxbQ9yfTLMfjEb4sPiarmfTpCNbNQrM/FWV4ZduHAEHy1XacXz+3I9+zIOB3hTwO7dY
         5rIAK/x3elfDc4oo3dxFCzLmK8RnxNZYVB1l53Fa4Ypi7ks7OKmQ0NBz6xfLKZ7kzXIO
         yOrfmXfzOupfGwJK1S8E7lRhdb4P+AshOxTfzekC4WyaEGgB+Ap6nFmb/hd4JfL4Pf2B
         QxkMpPWh28RTWUmHD2uDKsmv0JQNPMlsiuwRJq9gNs7cWHUTvXMiywkpQA+OcoM/c8ww
         F6Tg==
X-Gm-Message-State: APjAAAXvj4h+87bhZ6J2HZ89SUnNum/5nX1q5FBx3WTglDnSSmhXexWc
        oSNeR89AIRaeclzpNhP5YlE=
X-Google-Smtp-Source: APXvYqwUDppjzSfUVBMV4g4BO4GtTbeuOk/twDUtBSn5yr6ghJxzd6Ms2nzNzyirEfZxMMfClcTqlA==
X-Received: by 2002:a81:84d4:: with SMTP id u203mr1456335ywf.363.1551800559664;
        Tue, 05 Mar 2019 07:42:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1676])
        by smtp.gmail.com with ESMTPSA id d85sm4604058ywd.96.2019.03.05.07.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 07:42:38 -0800 (PST)
Date:   Tue, 5 Mar 2019 07:42:36 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: fix inode cgroup switching comment
Message-ID: <20190305154236.GA50184@devbig004.ftw2.facebook.com>
References: <20190305004617.142590-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305004617.142590-1-gthelen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:46:17PM -0800, Greg Thelen wrote:
> Commit 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb
> transaction and use it for stat updates") refers to
> inode_switch_wb_work_fn() which never got merged.  Switch the comments
> to inode_switch_wbs_work_fn().
> 
> Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
