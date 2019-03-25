Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A744C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43920823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PyRggYx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfCYRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:47:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfCYRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:47:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id r25so6640274lfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S5UyRuHVuUXWaWvAftQ+RrqzdKeuAGFwRT50Ta/UFFE=;
        b=PyRggYx2GW8cFTkwGf+23DBrjm8VfNC9im6QUs3L7YKc1g47iMrwGUqn/LCdy3SHXU
         Tzf52VRbxta4oKJjbhCO//gQeGGY+Q9UbmxrrQ8LuZM3DHDhRhs/BCKugbOhwV/umQS5
         IstwLZ2JSHjQgCYtOiTeUyv3/Fjvg7vyJQ9ho/Sj2A0kYeKknn3Zi0tHNmIhBmZY4DKE
         H6ExWJI8ehIDb++0P/xmJ1eN0M8h7ClmEJolf6q4NoSPXcpb/eGj/SUxUiuVGzwBDZZ4
         a2j9XRDe0+wtiLxBxjW81gkY2ZK9qi5pHtqoPxhYQJQue2bx4xs5zkJlh9K38QsIVeTW
         c0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S5UyRuHVuUXWaWvAftQ+RrqzdKeuAGFwRT50Ta/UFFE=;
        b=NgNIz9wgGOeJRBIvLLW+hx+8sN+rdzhQMqV7ZE6bAo76J5txyMnjOhe0q/TuDCVs3N
         Ow3O5hPsaWykjGML1InDWmr5wtVJJtdCrr+CCTqWrQ6RnAOvbbhSR5vgFjvzKTQB6CXD
         3PjUloFX5cssXGmZXoUQO1VK0CZ+opkFG3hJqwo2Z7dfdDldaImUQmKD+6omXwtoZLQh
         hhY+c7yUoaULrh1crFGxhk3tqvkSChHnE/2FtjPyIPpTgJW/umskGCLox3JE474SqTnF
         XahC3IejYuxBFzpUbP6/0Mb3G+1Ugjlv5TxwbGOJmmAwH8eVkfXTNITftdBY9dOO4qb5
         Y+2A==
X-Gm-Message-State: APjAAAUxZ+wQD6vzO3RB4ITYFqcr2z++WZq74H62I0fH36vQmUJvFMlv
        ehLslw+zJD+Wud5mlQ58mKV8Zw==
X-Google-Smtp-Source: APXvYqytSJnUFavFZw5eVVWaDeACX8dZsBE5EoTKe8L3dSu9GqqzRHfiBAgLpS6WDJ0fPicGEjzWTg==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr4978413lfh.168.1553536027619;
        Mon, 25 Mar 2019 10:47:07 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([178.127.192.30])
        by smtp.gmail.com with ESMTPSA id z73sm3468533lff.31.2019.03.25.10.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:47:06 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B0BA230123C; Mon, 25 Mar 2019 20:47:03 +0300 (+03)
Date:   Mon, 25 Mar 2019 20:47:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     TongZhang <ztong@vt.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, rientjes@google.com,
        aarcange@redhat.com, dave@stgolabs.net,
        kirill.shutemov@linux.intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Shen Wenbo <shenwenbosmile@gmail.com>
Subject: Re: Repost: Missing security_mmap_file() in remap_file_pages syscall
Message-ID: <20190325174703.5cxfgif3z7gdfqhu@kshutemo-mobl1>
References: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:33:51PM -0400, TongZhang wrote:
> Dear Kernel Developers,
> 
> We’d like to bring this up for a discussion again.
> 
> Several months ago we posted an email discussing a case where remap_file_pages() has no security_mmap_file() check.
> At that time we were told that do_mmap_pgoff() will base the new VMA permission on the old one.
> But somehow we still think the check is needed, for the reason that the advisory could first do a 
> mmap() which can pass SELinux check then remap using a completely different file or region of file,
> which could possibly pose a risk.

Could you elabarote on the risk you see? A bad scenario that could be
prevented with SELinux check would be helpful.

-- 
 Kirill A. Shutemov
