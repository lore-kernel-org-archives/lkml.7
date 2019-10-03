Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF520673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121857;
	bh=IiNF7g3a9jRvuphB6aBB5AqdNzMJI1Ybhw2eXhk+gHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q44iZrfsUWSYZVJSdYtCtADBDlrdtRvA9rz+qqhR4sHcjtFsSaaYUyYFlrxObVvAO
	 r4HCfzqr9eyukrRQOiqHSKYKJaQBIZZJ+/jXp+lbUfiL/zfm3+dcxJ4RwFi3IIiOl/
	 14RQNcJOamM0cJiy1DAYVNaKLs7SUz0qaUjJY2jY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393209AbfJCQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:57:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41024 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405847AbfJCQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so4512377qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e8BzLvzxhSD1GEQmtdUU7N2c1i7E39eDlvb8ocnPaV8=;
        b=NkDbA1wqK2hduwjGVEM8Une3SpfNMT7Q8dzFM7wCwGIj6kDU2FpNzG3ec9Ik3FKsN2
         X6IDCxIzw4Q88Me5bCXXkU6W0fIFeHmXL4rpu/TptEsQBuNbd89dr2fhxYqc3ZjRE2Fr
         4Muu5MmIveBWWx4WfvXP3ltqU7mxueHORFpFJg/Rs8NOdh0xc1BevuKE0TtA7RMFYmXi
         h8wCR0MoWiuwwuQ4rcrc0F+MGfhNRchXNPIxVBJmuEZUoagNxmhaKrQvSVxPA+PAfd1V
         H5TrRVU2Kj7A5unH5Jve27NwI4P3DZdsK147Xqt6ipv/byiAXxUQCmeBeVylppvK/WcS
         7X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8BzLvzxhSD1GEQmtdUU7N2c1i7E39eDlvb8ocnPaV8=;
        b=InngWEd2zeCgwPpGjE8ltuJ7VZMJNcbyp1QQa8oz2RNzUsvKWQK2/BCf07+3G/AK3e
         OOsUGmTN7dcJ1vA/zYsBVUlDe4G9GuWWQ1xylZX7XGP/6Uv7YBwGKMWG7+8e75Du5Fc1
         jJorBRlJJNHfS5NOW+2wxJbb8I3FxaguHQQkE96w+t4u8N2P9bjyWPD9BASfidA20pFL
         +IAncIoPJo9i3VfpTmOuKHznpndZs7lVe8g4n9hQ0g0ljCoYzq3an7XQWRb1x4meG/go
         lggldHmltrk4I89Ro91t5YpRcYFR0XGL/KC7ACSXjUCMHVFNREepeG1yhIEJnUjI5Ixz
         5xDA==
X-Gm-Message-State: APjAAAWmwpv706hbNNX7Ci5GPbuBkYVQJ6XkcreL/qShQyT7+tkgaELt
        LofZefArdmsM/l/rlLbt0H0=
X-Google-Smtp-Source: APXvYqwcFvRYFcVV7YdG5/RKU9ZKNOX3aiVhL4OtrkqdEzobX5hnUSwACn6isZd4HE3TVvIZcy6B3w==
X-Received: by 2002:a05:6214:4d:: with SMTP id c13mr9458951qvr.118.1570121386613;
        Thu, 03 Oct 2019 09:49:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:9f72])
        by smtp.gmail.com with ESMTPSA id d55sm1880845qta.41.2019.10.03.09.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:49:46 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:49:44 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Zdenek Sojka <zsojka@seznam.cz>
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com
Subject: Re: workqueue: PF_MEMALLOC task 14771(cc1plus) is flushing
 !WQ_MEM_RECLAIM events:gen6_pm_rps_work
Message-ID: <20191003164944.GB3247445@devbig004.ftw2.facebook.com>
References: <12X.2yh9.1rKbaucucGw.1TZ6EI@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12X.2yh9.1rKbaucucGw.1TZ6EI@seznam.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 26, 2019 at 09:06:58AM +0200, Zdenek Sojka wrote:
> I've hit the following dmesg with a 5.3.1 kernel; it looks similar to https://lkml.org/lkml/2019/8/28/754 , which should have been fixed as noted in https://lkml.org/lkml/2019/8/28/763 (if the patch is in the 5.3 release)

This isn't a wq problem per-se.  Can you repost w/ drm folks cc'd?

Thanks.

-- 
tejun
