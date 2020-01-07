Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A1BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5B2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZa3hb5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAGOCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:02:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47506 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbgAGOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578405718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMSZRJ2KkrIcw9LBhIKUV3xr6gpPQCCmKje4ZsF/tOI=;
        b=OZa3hb5dbIT8qyp0tQwuTNlbrgmxaALGzz5pKjTtxi0sPR02/54DgCIrkB/3TaJQpX2u4r
        NlSYwZ153pdgYPU7waCZHu0SIQL8LwwFiYzWT2mau3/9nNWKmVp70kH3Ak2geXEjPWKJpi
        wTeexx7/GLOTRtvCnTu9MkDsyMKNwyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Y_1qOG1zOraWf08cUilgjw-1; Tue, 07 Jan 2020 09:01:57 -0500
X-MC-Unique: Y_1qOG1zOraWf08cUilgjw-1
Received: by mail-wm1-f71.google.com with SMTP id c4so4135961wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMSZRJ2KkrIcw9LBhIKUV3xr6gpPQCCmKje4ZsF/tOI=;
        b=AW9zRx6O6/NtJ2hO52aNeFmrKQzJV3xZfW3HLHgyF0fwu3HS/u/tC6slCLd0yu+33Y
         ObxietCi2mtnqzyexbDiSdQiiACUptGxaqX2Y4Ivu7xf7boBoUWWTCr/iqrhB2mwfLTd
         Uh76rpzHAMWXA4GEIJuk4gaoL7s83LD9d0qlsCV27cCZohMHbE9iiDRBfJ5tGXePlABu
         NMv+iJJ3cINb9PwD8NNc49WQmJEDKgCfXDbNPq42qRmCzdpB33b2IwYE8E7TN3QJpFFp
         on7BZndRtzexLnzBaITSDxXLfhGiyVlVAjZ5s+grhoNycMOu4vozb0WvyiKZkZimpcse
         VKYA==
X-Gm-Message-State: APjAAAV8N/VEExvewki7yEdRA4PRz8jEAVj7vtA3FVxBjQf1vdUJEkvK
        4B66VurNYcH70Ch8w6kHbbcoxJFawHjTDk+fZUEVYjnvlxh56BZEGLvTK5lw6XXrHRr/IZvbs+j
        MBMHmm5EWmPNsCK4L18asmzft
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr108263621wrv.316.1578405716542;
        Tue, 07 Jan 2020 06:01:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4yWFbCHF76xC6f0TK81BtgyxtfyF+k91myZ31pvCNwbLGkiIy/kUhV3eL9xK6uQBOxoXugw==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr108263582wrv.316.1578405716256;
        Tue, 07 Jan 2020 06:01:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id x7sm75775317wrq.41.2020.01.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:01:55 -0800 (PST)
Subject: Re: [PATCH next] KVM: Fix debugfs_simple_attr.cocci warnings
To:     Chen Wandun <chenwandun@huawei.com>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1577151674-67949-1-git-send-email-chenwandun@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicolai Stange <nstange@suse.de>
Message-ID: <4f193d99-ee9b-5217-c2f6-3a8a96bf1534@redhat.com>
Date:   Tue, 7 Jan 2020 15:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1577151674-67949-1-git-send-email-chenwandun@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/19 02:41, Chen Wandun wrote:
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> for debugfs files.
> 
> Semantic patch information:
> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> imposes some significant overhead as compared to
> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

This patch was sent probably already two or three times, and every time
I've not been able to understand what is this significant overhead.

With DEFINE_DEBUGFS_ATTRIBUTE:

- the fops member is debugfs_open_proxy_file_operations, which calls
replace_fops so that the fops->read member is debugfs_attr_read on the
opened file

- debugfs_attr_read does

        ret = debugfs_file_get(dentry);
        if (unlikely(ret))
                return ret;
        ret = simple_attr_read(file, buf, len, ppos);
        debugfs_file_put(dentry);

With DEFINE_SIMPLE_ATTRIBUTE:

- the fops member is debugfs_full_proxy_open, and after
__full_proxy_fops_init fops->read is initialized to full_proxy_read

- full_proxy_read does

        r = debugfs_file_get(dentry);
        if (unlikely(r))
                return r;
        real_fops = debugfs_real_fops(filp);
        r = real_fops->name(args);
        debugfs_file_put(dentry);
        return r;

where real_fops->name is again just simple_attr_read.

So the overhead is really just one kzalloc every time the file is opened.

I could just apply the patch, but it wouldn't solve the main issue,
which is that there is a function with a scary name
("debugfs_create_file_unsafe") that can be used in very common
circumstances (with DEFINE_DEBUGFS_ATTRIBUTE.  Therefore, we could
instead fix the root cause and avoid using the scary API:

- remove from the .cocci patch the change from debugfs_create_file to
debugfs_create_file_unsafe.  Only switch DEFINE_SIMPLE_ATTRIBUTE to
DEFINE_DEBUGFS_ATTRIBUTE

- change debugfs_create_file to automatically detect the "easy" case
that does not need proxying of fops; something like this:

	const struct file_operations *proxy_fops;

	/*
	 * Any struct file_operations defined by means of
	 * DEFINE_DEBUGFS_ATTRIBUTE() is protected against file removals
	 * and thus does not need proxying of read and write fops.
	 */
	if (!fops ||
	    (fops->llseek == no_llseek &&
	     ((!fops->read && !fops->read_iter) ||
	      fops->read == debugfs_attr_read) &&
	     ((!fops->write && !fops->write_iter) ||
	      fops->write == debugfs_attr_write) &&
	     !fops->poll && !fops->unlocked_ioctl)
		return debugfs_create_file_unsafe(name, mode, parent,
						  data, fops);

	/* These are not supported by __full_proxy_fops_init.  */
	WARN_ON_ONCE(fops->read_iter || fops->write_iter);
	return __debugfs_create_file(name, mode, parent, data,
				    &debugfs_full_proxy_file_operations,
				     fops);

CCing Nicolai Stange who first introduced debugfs_create_file_unsafe.

Thanks,

Paolo

