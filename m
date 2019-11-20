Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F22C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E5222429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LC/n02Z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKTAIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:08:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45855 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfKTAIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:08:42 -0500
Received: by mail-qv1-f65.google.com with SMTP id g12so8965318qvy.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c87ZRnKfkFwb+Er5Nz+pUba1hzgIl8uANKfWQXKhD+E=;
        b=LC/n02Z1CrZwRGFSmBGeBRviEPvtZmLFw64zCE6Py0/spL5OmmjJpX9qSS+1BNRP8Y
         rBOnJ08/3J7IIqS2AmNzXh9ePuEIjDvGWgbpARXTadUZj7GSwd3Tfiz6U0aNYFlOD8yk
         oOKEttqnJ+ZIrvNTlKweQhhXPKM0Npi+CqImU6BEnf3Zy0oh2Xockiqo6nCsHsbFmn5q
         E/1XDcF+Asd0eJdyVIHphfyQf0Q1aWMiQPD9T8A6yZwSC2HZtGAVi44f0hIGf/8ui5ju
         5ykb4Fk/vDB80qjwizzbiFrALqXGvHsT282EdxTdaYrEP6IlyZ/6+tCHa7KBIFB3oCfE
         vJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c87ZRnKfkFwb+Er5Nz+pUba1hzgIl8uANKfWQXKhD+E=;
        b=Mk8FWs9K2VQGiJatBwfxyGHoK5cMkv4sV8gzz6H8nbYGlcln3P6PHfxpQfPz+IqKKi
         BFDUC8GQfKcrAMPVe6vCC2gowMFUxW6SKwVSiIZ4jtlyF4DrjS8Odt6WvX0ccFaa6k0F
         HAA0YRn6UwO5Qha5rnpJaieAJK8Tn7Eac6bSw3X6oegMxVEdsFREOAPd7bgT+a06m+QX
         XvN1IpJQ2Ybx0g5kE7/fX4gkppl/pS8a9kOVW9cGXmKAirwoTbnq8dq60jMWV1d29dq9
         +1/MMjYWHRGoN+BfE1KMsNRM5iiT6o3uvaAwjfrJg+bnSinFMdPOr8HRIcA2vX/BZBwZ
         p81Q==
X-Gm-Message-State: APjAAAVXqkVDYBAd5Yf+ZvKb0MK+gmIJ5KYXx9sos44L+0qlm60KFLG3
        9KbsnBDj6F8n+8+HW4Jd1rXTmg==
X-Google-Smtp-Source: APXvYqyHC6JpsyUgMnFH/vHr6GurwqIC7phi/jGWbasG+gvRWYCFc2oItzSzTNaOD726Ktw1Y+eW3Q==
X-Received: by 2002:a0c:dd01:: with SMTP id u1mr49357qvk.69.1574208521502;
        Tue, 19 Nov 2019 16:08:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s42sm13113000qtk.60.2019.11.19.16.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 16:08:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXDY0-0005ir-DI; Tue, 19 Nov 2019 20:08:40 -0400
Date:   Tue, 19 Nov 2019 20:08:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191120000840.GQ4991@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:55:35PM -0800, Rao Shoaib wrote:

> My intent is that we calculate and use the maximum buffer size using the
> maximum of, number of SGE's and inline data requested, not controlling the
> size of WQE buffer. If I was trying to limit WQE size I would agree with
> you. Defining MAX_WQE_SIZE based on MAX_SGE and recalculating MAX_SGE does
> not make sense to me. MAX_SGE and inline_data are independent variables and
> define the size of wqe size not the other wise around. I did make
> inline_dependent on MAX_SGE.

What you are trying to do is limit the size of the WQE to some maximum
and from there you can compute the upper limit on the SGE and the
inline data arrays, depending on how the WQE is being used.

If a limit must be had then the limit is the WQE size. It is also
reasonable to ask why rxe has a limit at all, or why the limit is so
small ie why can't it be 2k or something? But that is something else

Jason
