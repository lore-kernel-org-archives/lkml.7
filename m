Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A984CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAAF21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO2SmefH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJYXcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:32:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35943 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:32:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id bm15so3145796edb.3;
        Fri, 25 Oct 2019 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53yH7/uaXqdrwxgYB9Z47HSHpvLxk3mUn6GWgjoDX1k=;
        b=DO2SmefHOAxn4ZRC/98N4YdzE/zPlygnI3sdZ/lMw8GE1Y0Jn+4ecitQL7PrEYjGNw
         nQO6urZcflUp3c+zcDVjzayJv+IrElZA2btlmB3VaFWiL3jmKwLwSiQ1OxdhcsXuZI+L
         g+eV3KjvUpPKvnhtHgLRTuKuPpD0jg+V0ZN5qnxWgTpnXqsP+SDsqu0W0Bzb+stVXhgk
         RWjG2kHGTXqK0jCfgqtjCSzL8QQ4chhr/EyVRDBCuEXwVFT16w+jM6bUBju/OUqIoJDj
         KOp0FPD9cjau7zgCUdkP/nQ5aLjrK2hB9iKTIbO5A4dd0tc0wNwqKQoR4ZxZ6SNkIybw
         gWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53yH7/uaXqdrwxgYB9Z47HSHpvLxk3mUn6GWgjoDX1k=;
        b=lVXldsttfRBKfSEcvbvwN09r9mX0suxsDhGdq3SWPPTY82E1fYk+G5A6l2fyC/kWUX
         HiWITpyGrgbp4ALCmWw9VGdWtgjtVdW+wp8IAtFggLuRZF+XXI/FVOqRGUAicMz+L1f7
         RwlGT9fJrNXmfGwLfB/5S7bXRs+4SRDK1DdxqiePeTn0xRxlyPo38FDDa2d3sN+n3Ww0
         U8IIgwRr+FXyWCkC95+9UFgJzsO/X2zJHxCvGOz1Ip637VpqS2+rS5/aTPhgvO9yGLvq
         EEFUvTykd2XWsec481WZ0DFPe8iCfCGXu4SGfeJh1aj/nOyvoVliKKoxEGV2KZbXnRLu
         g6+w==
X-Gm-Message-State: APjAAAUQFGvkXZMgBA1aa5Cy+MBCxy71j9mRpd9CUSDX3MUQP8NTKSpA
        z3T2ruWyDRLJBiUF5kHtDrniFw/k8iElssbIyYY=
X-Google-Smtp-Source: APXvYqz769LDdVQAKT6dKxtfm0ChR8hbmqoc0jVwlkWk2TcKLi8TwfsfQMql2BOxt6F8LwNgS6lRRTuNz9I/hd3Zw1M=
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr5896396ejf.237.1572046361188;
 Fri, 25 Oct 2019 16:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191025225009.50305-1-john.stultz@linaro.org> <20191025225009.50305-2-john.stultz@linaro.org>
In-Reply-To: <20191025225009.50305-2-john.stultz@linaro.org>
From:   Rob Herring <rob.e.herring@gmail.com>
Date:   Fri, 25 Oct 2019 18:32:29 -0500
Message-ID: <CAC=3eda3sCMjCQbFX2Y0-6iVt-YRR7P_Y1ksJOsLw9CmJJRxbA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] dt-bindings: dma-buf: heaps: Describe CMA
 regions to be added to dmabuf heaps interface.
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 5:51 PM John Stultz <john.stultz@linaro.org> wrote:
>
> This binding specifies which CMA regions should be added to the
> dmabuf heaps interface.

Is this an ION DT binding in disguise? I thought I killed that. ;)

>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  .../bindings/dma/dmabuf-heap-cma.txt          | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt b/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt
> new file mode 100644
> index 000000000000..bde7b1f1c269
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt
> @@ -0,0 +1,31 @@
> +* DMA-BUF CMA Heap
> +
> +Specifies a CMA region that should be added to the dma-buf heaps
> +interface.
> +
> +Required properties:
> +- compatible: Must be "dmabuf-heap-cma"
> +- memory-region: phandle to a CMA reserved memory node
> +
> +Example:
> +This example has a camera CMA node in reserved memory, which is then
> +referenced by the dmabuf-heap-cma node.
> +
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               ...
> +               cma_camera: cma-camera {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0x0 0x24C00000 0x0 0x4000000>;
> +                       reusable;
> +               };
> +               ...
> +       };
> +
> +       cma_heap {
> +               compatible = "dmabuf-heap-cma";
> +               memory-region = <&cma_camera>;

Why the indirection here? Can't you just add a flag property to
reserved-memory nodes like we do to flag CMA nodes?

As I suspected, it's because in patch 2 you're just abusing DT to
instantiate platform devices. We already support binding drivers to
reserved-memory nodes directly.

Rob
