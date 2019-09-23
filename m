Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D7C4CED2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5820820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvIurzkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437522AbfIWRKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:10:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732910AbfIWRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569258614;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brtnUNEATJxaiEmZJMG7ZyzZu+Ldb+R0Iih2eWtZNa8=;
        b=CvIurzkUgXXwWaeRZFHy9j301sh+XRjQ129axRbcz3vxYFAltnTcG+DS10099kKtvNAnWm
        hyAZ0mDMFjBhAqdZoio/LZFJNydHiaBpDSKBNHQiHt3PEbZOizDET2hG4HOPPjkOXrVTiB
        ZeymYIv3TDz4WM1/u9bTNwcvWatQKUI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-fNfUA78ZPEO3DDUuqgQ4vQ-1; Mon, 23 Sep 2019 13:10:13 -0400
Received: by mail-io1-f70.google.com with SMTP id m3so24518191ion.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rh1uvaNsooagBW4WOK11wp/OzNbWIxJmJoNftck7Ang=;
        b=ef/BQiNpkD1F1ezldh4OJRPna0IOXBXwo9j7SBhxZ0pOgDL+Uj5vWC1TCWxEkUMfJa
         zrRtgG/97yZH6Lyu21Yx7XzhJVq23CuqeZ/5+U/qdZYKJkLSTHaPV47nNiCercSqUmg8
         iYOwuMcO4Uf784xnM2Iog0kSELsLnHgtU5ZRczXgo0B9uowDAzShZ9rLZHu4eEi6Nm3z
         y/i8BSNvLhv9f8xPARwSjI5BrbKb7VoeU4f7tHnQvmrojdQWzWf86b/4UIyaCDoLbfQs
         Zhlz8TFm5FKVA5ECRexQPE8TptUxNfV0fPM1hvstWRI56palTFIF2XZUZEG9CQxFNt9y
         QOig==
X-Gm-Message-State: APjAAAVL98WxQfHJr0cTvbsm+lBP+4LUsigO+U/hTZjcfGEsBY5uRhmu
        TGDx9s9KHm0UR4kIED+Mk3DJRLpqlAXPLNGN+ug2DOFooDGXg2mTC4w5tHraLTz5wJLFAJHCRKj
        0h9w5yu7JkuUgV5Z9j80BJI5z
X-Received: by 2002:a5e:9917:: with SMTP id t23mr308427ioj.141.1569258612799;
        Mon, 23 Sep 2019 10:10:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXT9PS2Bv55kiYnVhChrkQQVSNPJh291rae4rfNmJB3BZ6AEfm4CLIiEf4j7x0kpdjPLYidA==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr308405ioj.141.1569258612538;
        Mon, 23 Sep 2019 10:10:12 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id w7sm11707131iob.17.2019.09.23.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 10:10:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:10:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [RFC PATCH] tpm: only set efi_tpm_final_log_size after
 successful event log parsing
Message-ID: <20190923171010.csz4js3xs2mixmpq@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190918191626.5741-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190918191626.5741-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: fNfUA78ZPEO3DDUuqgQ4vQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts on this? I know of at least 2 Lenovo models that are
running into this problem.

In the case of the one I have currently have access to the problem is
that the hash algorithm id for an event isn't one that is currently in
the TCG registry, and it fails to find a match when walking the
digest_sizes array. That seems like an issue for the vendor to fix in the b=
ios,
but we should look at the return value of tpm2_calc_event_log_size and not
stick a negative value in efi_tpm_final_log_size.

