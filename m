Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE3FCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B6F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udbYnAFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfJULqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:46:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37898 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfJULqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:46:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so12453178wmi.3;
        Mon, 21 Oct 2019 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U1IQDTvaARLaVd24Zh1gpxsP2o000LM9KsLDvNwZvKQ=;
        b=udbYnAFz3mD3r3OJh4xHUpdLPntC2rn4pFfjH00JZZ95zXQ0TSvGeadqdngti7yNIW
         27MmJWPjyi+NdwWWrKVEKKrNJWRKvB6j7i7JymGAs43sQXsg9oMy5v7Ni9hN8ewjXdX/
         TMpjxI0C8FcNJP5K0x8lU1XFTpFPS82GCjZ/hemdfR5ybFaqZI1F/Uf304m8WPZa2RAn
         mh0lBHvie4hMRxls50k9uAqAxYv+uJXoUWG04gGGSXU6vX6RqDc5uy4o+0cwEnAreSvt
         YKhbjdJrnIOauaFHucVeNOUQjmfQnxHzSyJmi3xFh6LR9YngDl4HMdZGuWfsgxI9fh+K
         lw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U1IQDTvaARLaVd24Zh1gpxsP2o000LM9KsLDvNwZvKQ=;
        b=J4PqtAW+KdbhOmrPN3KhU9M8YnruRC+Wcs36aDUJ0BuKE5J6ZDdVajuFIRExlE1WnS
         6e3TCfUxteY57BYo94UIgXqwYUKnEdn6XHFh861H/SUZSCsWNFJhPZgMLHo7z0pf08RR
         S3pW/OKrW2qhDvywMkPd2gSBvl04P/x2PvkAo1xjrf/eNf0mRLkJ+oenWHo19hUKj2XQ
         UAxIru477MYJNLGjxOMdkYJRCX+6HNFJU6pEuohgYjBlW22elZpOqXUODl8VkqX/DkrG
         P25e/JX1NZ8jKMLUrkE80NDP+P/keltpgMcsn27m2Gtsyc9Y2BiaKw2+0u/BmpIG0KeW
         Zqnw==
X-Gm-Message-State: APjAAAW4wipKcEwuN+o0koLuY85DAiFr4yg1oFChL5iDFv35V85BCk4c
        7XQE4e1a9Scg7ZsP7ziqqQw=
X-Google-Smtp-Source: APXvYqxC5UL9u14Na2lUyp+kQoJTcCXOoxOAUG3UCJ3rO8yKGOC8uc0v2t5Cx4sGQYBIOx7EkapfFQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr17178705wmc.24.1571658358398;
        Mon, 21 Oct 2019 04:45:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c16sm986112wrw.32.2019.10.21.04.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:45:57 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:45:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Message-ID: <20191021114556.lk2zkha57xmav7xz@pali>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <20191021111136.adpxjxmmz4p2vud2@pali>
 <a4c42aa5-f9b7-4e74-2c11-220d45cb3669@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4c42aa5-f9b7-4e74-2c11-220d45cb3669@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2019 13:37:13 Maurizio Lombardi wrote:
> So, 2 FAT tables are probably not sufficient for recovery, 2 bitmaps are needed too.

Yes, I know. But code which I referred check both number of fat tables
and number of allocation bitmaps (as they are represented by one member
in boot sector structure).

> Btw, only Windows CE supported this.

Is this information based on some real tests? Or just from marketing or
Microsoft's information? (I would really like to know definite answer in
this area).

Because Microsoft says one thing in their FAT32 specification, second
thing described in their FAT implementation and thing thing is how it is
really implemented (in fatfast.sys kernel driver which is open source).

So I would be really careful about how MS's exfat.sys implementation is
working.

-- 
Pali Rohár
pali.rohar@gmail.com
