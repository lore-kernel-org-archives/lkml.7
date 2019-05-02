Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18920C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16C92063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deYS98jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEBU5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:57:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34162 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:57:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so728809lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pBJ9w6lgY/gbDSyW6tu8FbPiPrRqqN8hgCcI/ouWv4M=;
        b=deYS98jcrPo1YtSz5GL3B0iQfozu+v1yEvuPzAsdsWGhfbJyvv724RHPDCPBBUz193
         YmuuZ+3J9FDyqp4UAwMQnt6Danwa/3aTV1V/HxcOnba0F5DXgFVk8oJcsWcEBkao3Wau
         TDnrwHrKm3VF+k3A+EikcEYFO60/XJVCPvWztbFMfjxcKEDbQ6O5UvIjRLKjAhTcKMeg
         gWN4c3Y6aFwxybH+m+zq+OulOAjA6Fi7S2F2PDtnO/K+i+CDvNMhWXzzp1X8VRuAkqXM
         6ybTE89hB3ATBTkF4BitNCuLpA1YRtrkGikfV8/THNgtw6c/rGI9wxPDTBznvH9+NEkS
         5m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pBJ9w6lgY/gbDSyW6tu8FbPiPrRqqN8hgCcI/ouWv4M=;
        b=CRxwL0emVbgx1aBbfqMhwod16u+1laKjV1xnZh14OGYg7YyAfa6JXZSZL6GEwH3HC6
         9hFalXLZOQk3D2UXHXR+wCN7DOzsfGKsvzp56lWUuh0SRPyAE6jVP0gmPD6S6iIVpqcg
         cnB8SQRCMEaerY7teCMJ4/PZ57Vq4QCyrTH0Jzbf26iOLlwxpEm1/n9fcUepSQIunJtn
         7tVB7hBNG/waWm7MGYj85g+lsGnbtPGDJsz9uboCRIMLY/LXQdytB+A5KvX+s8DIhA0E
         2LVEjft+ynapgfAn7IlYtC6jzBuzPLnfWP5LrU3ivPPC07wUCSO5EGi0VlMrwnWF09S3
         VloQ==
X-Gm-Message-State: APjAAAWODNo47+k3qmuZih79HPVXzauHXRHywDmv2zcWhQxxpbHl7zRb
        XLF4fcv1gDqmFTh0ZbLAsWg=
X-Google-Smtp-Source: APXvYqxpwSHaqM6yCkiO3Pu3fwtOtpblG0k9kQIfYRQCf8nihjcaltZKVv+2R0xqJFSn+bFWlEOiAQ==
X-Received: by 2002:ac2:5307:: with SMTP id c7mr3062605lfh.58.1556830655847;
        Thu, 02 May 2019 13:57:35 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id j9sm11251lja.92.2019.05.02.13.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:57:34 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4DA9D4603CA; Thu,  2 May 2019 23:57:34 +0300 (MSK)
Date:   Thu, 2 May 2019 23:57:34 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: Re: [PATCH v3 2/2] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190502205734.GE2488@uranus.lan>
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
 <20190502125203.24014-1-mkoutny@suse.com>
 <20190502125203.24014-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502125203.24014-3-mkoutny@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 02:52:03PM +0200, Michal Koutný wrote:
> The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
> semaphore taken.") added synchronization of reading argument/environment
> boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
> arg_lock to protect arg_start|end and env_start|end in mm_struct")
> avoided the coarse use of mmap_sem in similar situations. But there
> still remained two places that (mis)use mmap_sem.
> 
> get_cmdline should also use arg_lock instead of mmap_sem when it reads the
> boundaries.
> 
> The second place that should use arg_lock is in prctl_set_mm. By
> protecting the boundaries fields with the arg_lock, we can downgrade
> mmap_sem to reader lock (analogous to what we already do in
> prctl_set_mm_map).
> 
> v2: call find_vma without arg_lock held
> v3: squashed get_cmdline arg_lock patch
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Mateusz Guzik <mguzik@redhat.com>
> CC: Cyrill Gorcunov <gorcunov@gmail.com>
> Co-developed-by: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
