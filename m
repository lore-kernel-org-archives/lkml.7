Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373AAC7E0B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CAE24790
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GoEVxkDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfLMSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:47:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60506 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:47:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIiSst185129;
        Fri, 13 Dec 2019 18:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=nHF3D5rToDF2m+wjiiIuxRwNgeRpClvkibOf1u+NmUU=;
 b=GoEVxkDe+0io0EkpUIVHQnpXIetfGrQsrMY3L2mhIc6i2DuLFRseEmEIKsdE7KWvbbCv
 RJ8848CCMxSFqALcyXdIwU3RT1bc+Mor6jwAIrBeyWBrG4lEDZHPYuaJQgnM4EPyjeC8
 VddEX6/21Kl+/55TnRARDkH6MtJ2hR1GDm8/R2vJnu8h9CmrudxgtqS/zjjrIeS69InR
 KoZU5lC/GEcneOzZaTnE69m8OpDr1+UL65SF3dn6sWsTW3q12n8zQXwl9zX3A8RKLzSZ
 dRJV6kmKDVnyKH//h2KI4KJyw2/r3l9KBUragEnEDW0funSdq3mYOm16G2KtX7gIT9uf fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wr4qs2njn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:44:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIdClv149742;
        Fri, 13 Dec 2019 18:44:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wvdtv8bd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:44:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDIiJBk027802;
        Fri, 13 Dec 2019 18:44:19 GMT
Received: from [10.152.33.254] (/10.152.33.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 10:44:19 -0800
Subject: Re: [GRUB PATCH 1/1] loader/i386/linux: Fix an underflow in the
 setup_header length calculation
To:     Daniel Kiper <daniel.kiper@oracle.com>, grub-devel@gnu.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, eric.snowberg@oracle.com, hpa@zytor.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, phcoder@gmail.com, rdunlap@infradead.org
References: <20191202172939.29271-1-daniel.kiper@oracle.com>
From:   Ross Philipson <ross.philipson@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 xsBNBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAHNKlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPsLAlAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMXOwE0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAcLAfAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <7c512bb8-8c55-803d-3eee-2198201c56cb@oracle.com>
Date:   Fri, 13 Dec 2019 13:43:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191202172939.29271-1-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 12:29 PM, Daniel Kiper wrote:
> Recent work around x86 Linux kernel loader revealed an underflow in the
> setup_header length calculation and another related issue. Both lead to
> the memory overwrite and later machine crash.
> 
> Currently when the GRUB copies the setup_header into the linux_params
> (struct boot_params, traditionally known as "zero page") it assumes the
> setup_header size as sizeof(linux_i386_kernel_header/lh). This is
> incorrect. It should use the value calculated accordingly to the Linux
> kernel boot protocol. Otherwise in case of pretty old kernel, to be
> exact Linux kernel boot protocol, the GRUB may write more into
> linux_params than it was expected to. Fortunately this is not very big
> issue. Though it has to be fixed. However, there is also an underflow
> which is grave. It happens when
> 
>   sizeof(linux_i386_kernel_header/lh) > "real size of the setup_header".
> 
> Then len value wraps around and grub_file_read() reads whole kernel into
> the linux_params overwriting memory past it. This leads to the GRUB
> memory allocator breakage and finally to its crash during boot.
> 
> The patch fixes both issues. Additionally, it moves the code not related to
> grub_memset(linux_params)/grub_memcpy(linux_params)/grub_file_read(linux_params)
> section outside of it to not confuse the reader.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Yes this looks correct. The length should be based off the jmp offset
byte and not the size of the structure defined in GRUB.

Reviewed-by: Ross Philipson <ross.philipson@oracle.com>

> ---
>  grub-core/loader/i386/linux.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/grub-core/loader/i386/linux.c b/grub-core/loader/i386/linux.c
> index d0501e229..ee95cd374 100644
> --- a/grub-core/loader/i386/linux.c
> +++ b/grub-core/loader/i386/linux.c
> @@ -761,17 +761,12 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>      goto fail;
>  
>    grub_memset (&linux_params, 0, sizeof (linux_params));
> -  grub_memcpy (&linux_params.setup_sects, &lh.setup_sects, sizeof (lh) - 0x1F1);
> -
> -  linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
> -  linux_params.kernel_alignment = (1 << align);
> -  linux_params.ps_mouse = linux_params.padding10 =  0;
>  
>    /*
>     * The Linux 32-bit boot protocol defines the setup header end
>     * to be at 0x202 + the byte value at 0x201.
>     */
> -  len = 0x202 + *((char *) &linux_params.jump + 1);
> +  len = 0x202 + *((char *) &lh.jump + 1);
>  
>    /* Verify the struct is big enough so we do not write past the end. */
>    if (len > (char *) &linux_params.edd_mbr_sig_buffer - (char *) &linux_params) {
> @@ -779,10 +774,13 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>      goto fail;
>    }
>  
> +  grub_memcpy (&linux_params.setup_sects, &lh.setup_sects, len - 0x1F1);
> +
>    /* We've already read lh so there is no need to read it second time. */
>    len -= sizeof(lh);
>  
> -  if (grub_file_read (file, (char *) &linux_params + sizeof (lh), len) != len)
> +  if ((len > 0) &&
> +      (grub_file_read (file, (char *) &linux_params + sizeof (lh), len) != len))
>      {
>        if (!grub_errno)
>  	grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"),
> @@ -790,6 +788,9 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>        goto fail;
>      }
>  
> +  linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
> +  linux_params.kernel_alignment = (1 << align);
> +  linux_params.ps_mouse = linux_params.padding10 = 0;
>    linux_params.type_of_loader = GRUB_LINUX_BOOT_LOADER_TYPE;
>  
>    /* These two are used (instead of cmd_line_ptr) by older versions of Linux,
> 

