Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDCF20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i+vIrFkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbgAISKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:10:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34013 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbgAISKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:10:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so6654218qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QYZyDBxeJN3VU/Z0akCtNQf4HyHME9Tnn6OBKwEbI8=;
        b=i+vIrFkVhNXBZMoERSSUvS2Qk0BqcHa21Sqlcrehd20FjlnCaUYvrWqLyr0T3ZLKiD
         FjO30OzpcIMZJW0L7yWFmrtZAXgfcl82RWRqLuMMBDnTGOZ5UqaXOWQzkFSOv8mQwJvs
         bop+05Eoa3AiB6Y/kXaZ58r72mZyBYJclJEloK7dx7uueawHcM35DzGOi+KbKn25HZ2D
         b5vI59/tV03t9naGFs+K3CdsLj7nuVygGBHHZwekdhBOHAkjhG03xxvqo6POkvtr58AY
         38aZIt4fZfNjF2R6ZEhhkdK0zU+kRl/kvuPJZwgZv1NcuhYt+vp13Semad83a4xueGWN
         CTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QYZyDBxeJN3VU/Z0akCtNQf4HyHME9Tnn6OBKwEbI8=;
        b=pqyS6ygbvmXCWj7SOJT91LB+MkyCTwCQhJvRfLV8GRi2oGLFG+o9jexxARxB1F1pPa
         8D5ihYZzZnswaX92Ae4VGz8xoFz+NaaHGBAhTz6HwLSeZAUG2huDECUC6bJS1Jsvbnf4
         ANn5a9x8G9V5Q7f2t9jpRbps+jYzgQEHpQoZjgV2nEZJh6rcoyL+bMvMW7p8OaZCBnwZ
         seQtKJcWvQaPlwusgwGfEUUqsh8+GgVhiWxLmLPOBHkQi7qY3n1a8jPf+/9pOsmAWnj4
         TDwZWkTAXqaMgQzqRErcbyccvSfcWlkCTxpYECB1b416uA4Tu1jTEqamSLIm8yilqfUf
         tWog==
X-Gm-Message-State: APjAAAX0TxYztdJ2XfVvM28HcIrqX+rOrgdtc/3WhbkgeERY+HcT91Be
        Zo4FBlVnig9Je1poPSEMd+tYdA==
X-Google-Smtp-Source: APXvYqwDDMBGM6inrZQKFmQK40divx6D3kYVrebZh7EmlkxFsfLJxK36AvJD/AON7sxFauHvMR6DNw==
X-Received: by 2002:ac8:53cb:: with SMTP id c11mr8971667qtq.14.1578593439653;
        Thu, 09 Jan 2020 10:10:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 206sm3367074qkf.132.2020.01.09.10.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 10:10:39 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipcGU-00019D-Hs; Thu, 09 Jan 2020 14:10:38 -0400
Date:   Thu, 9 Jan 2020 14:10:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200109181038.GA24939@ziepe.ca>
References: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
 <20200107203354.GD26174@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107203354.GD26174@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 01:38:50PM +0530, madhuparnabhowmik04@gmail.com wrote:

> Alternatively, it can be lockdep_is_held(ibp->rvp.lock).
> Please refer to the macro(link below) and let me know if the usage of lock_is_held()
> in the patch is correct.

lock_is_held is the normal way to write this

Jason
